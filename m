Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030340AbVKHTMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030340AbVKHTMc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 14:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030342AbVKHTMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 14:12:32 -0500
Received: from sccrmhc12.comcast.net ([63.240.77.82]:13974 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1030340AbVKHTMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 14:12:31 -0500
In-Reply-To: <20051108184957.GF6129@thunk.org>
References: <Pine.LNX.4.61.0511081040580.3894@chaos.analogic.com> <3587A59B-14FA-4E0F-A598-577E944FCF36@comcast.net> <20051108172244.GR7992@ftp.linux.org.uk> <20051108184957.GF6129@thunk.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AD464EBF-4A7C-4079-923D-C060D379C69B@comcast.net>
Cc: Al Viro <viro@ftp.linux.org.uk>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: Compatible fstat()
Date: Tue, 8 Nov 2005 14:12:24 -0500
To: "Theodore Ts'o" <tytso@mit.edu>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 8, 2005, at 1:49 PM, Theodore Ts'o wrote:

> e2fsprogs falls back to using a
> binary search using SEEK_SET to find the device size.

Binary search of what? I tried to read the relevant code in getsize.c  
but apart from suspecting that the binary search thing might be  
specific to ext2fs I didn't quite understand what's going on in the  
code.  (Will it work irrespective of the file system presence on the  
device?)

Thanks
Parag

