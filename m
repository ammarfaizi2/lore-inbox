Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267221AbTBQRYq>; Mon, 17 Feb 2003 12:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267224AbTBQRYq>; Mon, 17 Feb 2003 12:24:46 -0500
Received: from [213.86.99.237] ([213.86.99.237]:38132 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S267221AbTBQRYo>; Mon, 17 Feb 2003 12:24:44 -0500
Subject: Re: ext3 clings to you like flypaper
From: David Woodhouse <dwmw2@infradead.org>
To: James Bourne <jbourne@mtroyal.ab.ca>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.51.0302171014320.8008@skuld.mtroyal.ab.ca>
References: <78320000.1045465489@[10.10.2.4]>
	 <1045482621.29000.40.camel@passion.cambridge.redhat.com>
	 <2460000.1045500532@[10.10.2.4]>
	 <Pine.LNX.4.51.0302171014320.8008@skuld.mtroyal.ab.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045503270.17498.29.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 17 Feb 2003 17:34:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-17 at 17:17, James Bourne wrote:
> > No, but it remounts the disk read-write after it mounts it read-only.
> > It can switch from ext2 to ext3 at that point.
> 
> This is a function of your distribution.  The
> init scripts *should* read /etc/fstab after the kernel mounts /
> ro and then remount / rw with whatever other options are specified.

No. You can't remount between ext2 and ext3 like you can for ro/rw.
You'd have to unmount it completely and remount it.

-- 
dwmw2
