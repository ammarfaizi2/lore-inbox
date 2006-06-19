Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbWFSKfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWFSKfe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 06:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWFSKfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 06:35:33 -0400
Received: from flexserv.de ([213.239.215.214]:31887 "EHLO lion.flexserv.de")
	by vger.kernel.org with ESMTP id S932354AbWFSKfc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 06:35:32 -0400
To: "Avuton Olrich" <avuton@gmail.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       linux-xfs@oss.sgi.com
Subject: Re: XFS crashed twice, once in 2.6.16.20, next in 2.6.17,
 reproducable
Organization: Flexserv
In-Reply-To: <3aa654a40606190044q43dca571qdc06ee13d82d979@mail.gmail.com> (Avuton
 Olrich's message of "Mon, 19 Jun 2006 00:44:58 -0700")
References: <3aa654a40606190044q43dca571qdc06ee13d82d979@mail.gmail.com>
From: daniel+devel.linux.lkml@flexserv.de
X-GPG-ID: 0x7B196671
X-GPG-FP: A9CE 5788 44D3 A1A2 46B6  A727 53D8 DD4B 7B19 6671
X-message-flag: Formating hard disk. please wait...   10%...   20%...
Date: Mon, 19 Jun 2006 12:35:25 +0200
Message-ID: <87slm15t76.fsf@xserver.flexserv.de>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Avuton Olrich" <avuton@gmail.com> writes:

The same here.
after a complete mkfs.xfs under 2.6.17-rc6 it was solved.

Same if i boot 2.6.8 mk.xfs, boot into 2.6.16 the xfs get "shreddered"
a directly boot from .8 to .17-rc6 works. so i think there was a bug in .16
in the transition of the xfs wich got solved somewhere in the .17.rc? time.

> Filesystem "sda1": Corruption of in-memory data detected.  Shutting
> down filesystem: sda1

Daniel

