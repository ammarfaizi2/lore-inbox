Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263689AbSJGWgu>; Mon, 7 Oct 2002 18:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263688AbSJGWgu>; Mon, 7 Oct 2002 18:36:50 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:53749 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263689AbSJGWgt>; Mon, 7 Oct 2002 18:36:49 -0400
Subject: Re: The end of embedded Linux?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christer Weinigel <christer@weinigel.se>
Cc: simon@baydel.com, "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <87smzhzy6l.fsf@zoo.weinigel.se>
References: <3DA16A9B.7624.4B0397@localhost>
	<3DA1CF36.19659.13D4209@localhost>
	<1034022158.26550.28.camel@irongate.swansea.linux.org.uk> 
	<87smzhzy6l.fsf@zoo.weinigel.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 Oct 2002 23:52:18 +0100
Message-Id: <1034031138.26473.40.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-07 at 23:22, Christer Weinigel wrote:
> #define printk_debug(xxx...) printk(KERN_DEBUG, xxx...)
> #define printk_info(xxx...) printk(KERN_INFO, xx...)
> #else
> #define printk_debug(xxx...) do { } while (0)
> #define printk_info(xxx...) do { } while (0)

That might make a lot of sense. The macros in question would need a bit
of hand checking for side effects in calls but yes this is the kind of
thing that can be good

