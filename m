Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263435AbSIQArv>; Mon, 16 Sep 2002 20:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263446AbSIQArv>; Mon, 16 Sep 2002 20:47:51 -0400
Received: from gw.lowendale.com.au ([203.26.242.120]:7952 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S263435AbSIQAru>; Mon, 16 Sep 2002 20:47:50 -0400
Date: Tue, 17 Sep 2002 10:53:32 +1000 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: Chin-Tser Huang <chuang@cs.utexas.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: save variables to hard disk at kernel mode
In-Reply-To: <Pine.LNX.4.33.0209161818120.26471-100000@nurse.cs.utexas.edu>
Message-ID: <Pine.LNX.4.05.10209171051100.16502-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Sep 2002, Chin-Tser Huang wrote:

> I would like to implement at the kernel a save that
> can periodically store the value of some variables
> to the hard disk. Could anyone please tell me what
> function can I use to achieve this? Will this save
> block the operation of other functions? Thank you
> very much for your help!

Write a module to publish the variables, and do teh rest in user-space
(e.g. cron-job)?

The book "Linux Device Drivers" (2nd Ed) does this kind of thing as an
example for PCI data.

HTH,
Neale.

