Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265769AbUA0Udx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 15:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265783AbUA0Udx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 15:33:53 -0500
Received: from ns.suse.de ([195.135.220.2]:32488 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265769AbUA0Udt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 15:33:49 -0500
Date: Tue, 27 Jan 2004 21:28:53 +0100
From: Karsten Keil <kkeil@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: ISDN CAPI (avm b1pci) doesn't work, occasionally freezes Kernel (2.6.1)
Message-ID: <20040127202853.GA20425@pingi3.kke.suse.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200401181746.i0IHkO2G002776@reason.gnu-hamburg> <1074468927.2722.2.camel@server> <m3r7xwqjue.fsf@reason.gnu-hamburg> <1074531587.1833.5.camel@server> <m3oet0dkti.fsf@reason.gnu-hamburg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3oet0dkti.fsf@reason.gnu-hamburg>
User-Agent: Mutt/1.4.1i
Organization: SuSE Linux AG
X-Operating-System: Linux 2.4.21-166-default i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 04:23:05PM +0100, Georg C. F. Greve wrote:
>  || On Mon, 19 Jan 2004 14:59:48 -0200
>  || fcp <fcp@pop.co.za> wrote: 
> 
>  f> He advised me this morning that the latest i4l cvs branch kernel26
>  f> version (old isdn system) fixes the problems we are having with
>  f> the 2.6.1 kernel. Haven't had a chance to test this yet.
> 
> Ah, so 2.6.2 should fix the problem? Good.
> 

I sent a big patch to Linus (against 2.6.2-rc2), you will find the patch at
ftp://ftp.isdn4linux.de/pub/isdn4linux/kernel/v2.6.
It fix some small problems with the CAPI2.0 implementation/AVM active cards
and is a new I4L/HiSax implementation based on the stable 2.4 code base. 
It's successfull tested by a handfull people and I run it with all cards
I own (~40 different types) without outstanding problems so far.

Currently untested:
Teles PCMCIA
Elsa PCMCIA
some old ISA cards

-- 
Karsten Keil
SuSE Labs
ISDN development
