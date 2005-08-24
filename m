Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbVHXV2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbVHXV2n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 17:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbVHXV2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 17:28:43 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:1787 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932255AbVHXV2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 17:28:43 -0400
From: Hans-Peter Jansen <hpj@urpla.net>
To: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] kernel spams syslog every 10 sec with w1 debug
Date: Wed, 24 Aug 2005 23:28:36 +0200
User-Agent: KMail/1.8
Cc: Andi Kleen <ak@suse.de>, Olaf Hering <olh@suse.de>,
       linux-kernel@vger.kernel.org
References: <20050812150748.GA6774@suse.de.suse.lists.linux.kernel> <p73fytf2miq.fsf@verdi.suse.de> <20050812160046.GA13749@redhat.com>
In-Reply-To: <20050812160046.GA13749@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508242328.37356.hpj@urpla.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:18d01dd0a2a377f0376b761557b5e99a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 12. August 2005 18:00 schrieb Dave Jones:
> On Fri, Aug 12, 2005 at 05:38:37PM +0200, Andi Kleen wrote:
>  > Olaf Hering <olh@suse.de> writes:
>  > > Bug 104020 - kernel spams syslog every 10 sec with: w1_driver
>  > > w1_bus_master1: No devices present on the wire.
>  > >
>  > > After installing 10.0 B1, I found this in my syslog:
>  > > Aug 10 23:40:06 linux kernel: w1_driver w1_bus_master1: No
>  > > devices present on the wire. Aug 10 23:40:16 linux kernel:
>  > > w1_driver w1_bus_master1: No devices present on the wire.
>  >
>  > More interesting is why this thing is running at all.
>  > It shouldn't.
>
> Doesnt that get loaded if there's a Matrox card present ?
> (I am completely guessing here, so could be way off base).

Guess matched! Most of my systems run these (should I say unfortunately 
8|)

And sorry for the late reply. I didn't notice, that my report leaked 
into lkml.. ;-)

Pete
