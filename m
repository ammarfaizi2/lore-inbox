Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbUDJUau (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 16:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbUDJUat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 16:30:49 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:29702 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S262101AbUDJU3n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 16:29:43 -0400
Date: Sat, 10 Apr 2004 22:29:37 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: fledely <fledely@bgumail.bgu.ac.il>, linux-ntfs-dev@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Accessing odd last partition sector (was: [Linux-NTFS-Dev] mkntfs dirty volume marking)
Message-ID: <20040410202937.GB1909@wsdw14.win.tue.nl>
References: <001601c41db7$aa0a02e0$0100000a@p667> <Pine.LNX.4.21.0404091247430.22481-100000@mlf.linux.rulez.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0404091247430.22481-100000@mlf.linux.rulez.org>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : mailhost.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2004 at 01:38:51PM +0200, Szakacsits Szabolcs wrote:

> > TODO.ntfsprogs conatins the following TODO item under mkntfs:
> >  - We don't know what the real last sector is, thus we mark the volume
> > dirty and the subsequent chkdsk (which will happen on reboot into
> > Windows automatically) recreates the backup boot sector if the Linux
> > kernel lied to us about the number of sectors.

The ioctl BLKGETSIZE64 will tell you the size (in bytes) of a block device.

Andries
