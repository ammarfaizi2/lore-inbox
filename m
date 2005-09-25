Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbVIYBka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbVIYBka (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 21:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbVIYBka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 21:40:30 -0400
Received: from main.gmane.org ([80.91.229.2]:48560 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750811AbVIYBk3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 21:40:29 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Carlo J. Calica" <ccalica@gmail.com>
Subject: Re: kernel 2.6.13, USB keyboard and X.org
Followup-To: gmane.linux.kernel
Date: Sat, 24 Sep 2005 17:04:17 -0700
Message-ID: <dh4phg$e4r$1@sea.gmane.org>
References: <433191A2.9030702@terra.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: vsat-148-64-17-232.c050.t7.mrt.starband.net
User-Agent: KNode/0.9.0
Cc: xorg@freedesktop.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Piter Punk wrote:

> But, when i start X i got a second problem, is impossible to type
> only one letter, one touch in a key makes a lot of letters, like that:
> 
> lllllliiiiiiinnnnnnnnuuuuxxxxx
> 
> instead
> 
> linux
> 

I have the same problem, with my dual core athlon64.  Booting a uniprocessor
kernel solves it.  Another work around is turning off key repeat.

Best solution is setting processor affinity for the keyboard irq handler and
X to the same cpu.  Seems to be a race condition of some sort.  If a X
developer wants to work with me to debug contact me at
ccalica_at_gmail.com.  I'm using gmane to access the list (occasionally).

Good luck.

Carlo J. Calica


