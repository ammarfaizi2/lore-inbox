Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbUCCH62 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 02:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262414AbUCCH62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 02:58:28 -0500
Received: from smtp5.wanadoo.fr ([193.252.22.26]:16477 "EHLO
	mwinf0503.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262413AbUCCH60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 02:58:26 -0500
Date: Wed, 3 Mar 2004 08:58:42 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
To: Dave Jones <davej@redhat.com>, Davi Leal <davi@leals.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.2, AMD kernel: MCE: The hardware reports a non fatal, correctable incident
Message-ID: <20040303085842.GB399@zaniah>
References: <200403021900.16085.davi@leals.com> <20040302215554.GA29752@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040302215554.GA29752@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Mar 2004 at 21:55 +0000, Dave Jones wrote:

> On Tue, Mar 02, 2004 at 07:00:16PM +0100, Davi Leal wrote:
>  > What about this message?. Note that the system works. I have not had to 
>  > reboot. What meens the below message?.
>  > 
> 
> The original plan behind that option was to find hardware faults early,
> but it seems to trigger a lot of false positives for various reasons.
> Part of this problem is that MCEs can also be generated on some hardware
> by doing something silly like reading from a reserved part of your
> motherboard chipset..
> 
> There are also CPU errata that can cause them to falsely trigger in
> some unusual cases, but I've not had time to go through the various
> errata datasheets to blacklist affected CPUs unfortunatly.
> 
> I'm toying with the idea of marking it CONFIG_BROKEN for 2.6,
> and fixing it up later.

I'm unsure if it's a good idea it's broken only on broken HW, people
wanting stable box try to buy sane HW and don't enable CONFIG_BROKEN
so they will never see if their HW are starting to be out of spec.

Perhaps rewording the option help and the error message to say it's
known to report false positive...


regards,
Phil
