Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266790AbUIEO67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266790AbUIEO67 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 10:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266758AbUIEO67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 10:58:59 -0400
Received: from the-village.bc.nu ([81.2.110.252]:9116 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266793AbUIEO6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 10:58:53 -0400
Subject: Re: [2.4.25] "pc_keyb: controller jammed (0xFF)" on Super
	Micro	P5MMA98
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <6E58E82C-FEF1-11D8-82A2-000393ACC76E@mac.com>
References: <1B6CEB06-FE2B-11D8-B9BD-000393ACC76E@mac.com>
	 <1094316425.10555.32.camel@localhost.localdomain>
	 <6E58E82C-FEF1-11D8-82A2-000393ACC76E@mac.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094392592.1251.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 05 Sep 2004 14:56:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-09-05 at 05:09, Kyle Moffett wrote:
> I've already tried both settings for "USB legacy", neither work.  I'm
> currently attempting to update the BIOS. The update I tried a couple
> weeks ago didn't work and gave an error, but there appears to be a new
> one out, so I'm trying that.  Is there anything else that it could be?  
> What
> exactly does the keyboard code check when it generates that error?

At that point it is talking to the keyboard controller (or BIOS
emulation of keyboard controller - not all machines have a real one any
more and emulation is also always used for USB legacy). The error
normally indicates the port is not responding.

