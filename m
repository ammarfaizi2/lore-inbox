Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965212AbVKHR6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965212AbVKHR6N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 12:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965223AbVKHR6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 12:58:13 -0500
Received: from rwcrmhc14.comcast.net ([204.127.198.54]:9446 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S965235AbVKHR6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 12:58:11 -0500
In-Reply-To: <20051108172244.GR7992@ftp.linux.org.uk>
References: <Pine.LNX.4.61.0511081040580.3894@chaos.analogic.com> <3587A59B-14FA-4E0F-A598-577E944FCF36@comcast.net> <20051108172244.GR7992@ftp.linux.org.uk>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <23F8E4C6-3141-4ECB-B3FF-E9BE6D261EE1@comcast.net>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: Compatible fstat()
Date: Tue, 8 Nov 2005 12:58:08 -0500
To: Al Viro <viro@ftp.linux.org.uk>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 8, 2005, at 12:22 PM, Al Viro wrote:
>
> 	fd = open(bdev, O_RDONLY);
> 	lseek(fd, SEEK_END, 0);
> 	size = lseek(fd, SEEK_SET, 0);
> 	close(fd);
>
> i.e. same as for regular files.  Won't be portable, though...

For some reason this didn't work for bdev == "/dev/hda" - Size is  
returned as 0..

Parag
