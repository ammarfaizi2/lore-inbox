Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270672AbUJULGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270672AbUJULGu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 07:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270675AbUJULFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 07:05:13 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:19420 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S270672AbUJUKx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 06:53:56 -0400
Subject: Re: Linux v2.6.9 (Strange tty problem?)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul <set@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20041021024132.GB6504@squish.home.loc>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org>
	 <20041021024132.GB6504@squish.home.loc>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098349651.17067.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 21 Oct 2004 10:07:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-10-21 at 03:41, Paul wrote:
> permanently unresponsive. (this burst of 'noise', seems to happen
> periodicly, and is a repetition of this:
> ~}#!}!}!} }8}!}$}"} }"}&} } } } }%}&]O='}'}"}(}"D~ 	)

Thats a PPP LCP conf request as far as I can decode it. You've got
a stuck pppd somewhere - thats a minor bug in 2.6.9rc and 2.6.9 that got
introduced by the tty changes. I'll try and fix it ASAP if Paul doesn't
beat me to it.

kill the stuck pppd


> 
