Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274823AbTGaQn3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 12:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274824AbTGaQn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 12:43:29 -0400
Received: from fed1mtao03.cox.net ([68.6.19.242]:2966 "EHLO fed1mtao03.cox.net")
	by vger.kernel.org with ESMTP id S274823AbTGaQn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 12:43:28 -0400
Date: Thu, 31 Jul 2003 09:43:26 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Ihar Philips Filipau <filia@softhome.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.6 size increase
Message-ID: <20030731164326.GG27214@ip68-0-152-218.tc.ph.cox.net>
References: <eLiy.31J.3@gated-at.bofh.it> <eLBW.3eJ.7@gated-at.bofh.it> <eLVb.3yF.1@gated-at.bofh.it> <eOJn.5NI.1@gated-at.bofh.it> <f1dJ.GS.21@gated-at.bofh.it> <faTE.2LQ.3@gated-at.bofh.it> <fd56.4Te.9@gated-at.bofh.it> <fdRv.5uB.9@gated-at.bofh.it> <fnHd.54o.19@gated-at.bofh.it> <3F294461.2020902@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F294461.2020902@softhome.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 06:31:29PM +0200, Ihar Philips Filipau wrote:
> Tom Rini wrote:
> >
> >Power Management, sysfs plays / will play a role in finding out the order
> >in which devices get powered down.  This is important on some types of
> >embedded devices (and arguably important everywhere).
> >
> 
>   You are contradicting to yourself.
> 
>   I have participated in creation of two specialized embedded systems, 
> and currently going into third one.
>   Every system were need some specialized shutdown sequence.
>   None of them were need power saving.

Shutdown != sleep.  If you want to wake devices up again, you need to do
them in the right order.

-- 
Tom Rini
http://gate.crashing.org/~trini/
