Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282664AbRLQTyD>; Mon, 17 Dec 2001 14:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282691AbRLQTxy>; Mon, 17 Dec 2001 14:53:54 -0500
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:57066 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S282664AbRLQTxk>; Mon, 17 Dec 2001 14:53:40 -0500
Message-ID: <59885C5E3098D511AD690002A5072D3C42D7FD@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'otto.wyss@bluewin.ch'" <otto.wyss@bluewin.ch>,
        Alexander Viro <viro@math.psu.edu>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Booting a modular kernel through a multiple streams file
Date: Mon, 17 Dec 2001 11:53:34 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Otto Wyss [mailto:otto.wyss@bluewin.ch]
> You have to admit that a multiple streams file format 
> (regardless which kind)
> would be a good solution to the booting of a modular kernel. 
> Anyway this format
> has to be supported by the kernel itself and in some extend 
> by any boot loader.
> So anybody has to write a kernel module for the cpio/tar 
> format and help with
> implementing it into  boot loaders. Maybe you could give some help. 

I don't think multiple streams is a good idea, but did you all see the patch
by Christian Koenig to let the bootloader load modules? That seems to solve
the problem nicely.

Regards -- Andy
