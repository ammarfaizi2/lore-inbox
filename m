Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263320AbSJ3C2A>; Tue, 29 Oct 2002 21:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263321AbSJ3C2A>; Tue, 29 Oct 2002 21:28:00 -0500
Received: from anchor-post-39.mail.demon.net ([194.217.242.80]:13308 "EHLO
	anchor-post-39.mail.demon.net") by vger.kernel.org with ESMTP
	id <S263320AbSJ3C17>; Tue, 29 Oct 2002 21:27:59 -0500
Message-ID: <3DBF43ED.70001@lougher.demon.co.uk>
Date: Wed, 30 Oct 2002 02:29:01 +0000
From: Phillip Lougher <phillip@lougher.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020604
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ANNOUNCEMENT: Squashfs released (a highly compressed filesystem)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First release of squashfs.  Squashfs is a highly compressed read-only 
filesystem for Linux (kernel 2.4.x).  It uses zlib compression to 
compress both files, inodes and directories.  Inodes in the system are 
very small and all blocks are packed to minimise data overhead. Block 
sizes greater than 4K are supported up to a maximum of 32K.

Squashfs is intended for general read-only filesystem use, for archival 
use, and in embedded systems where low overhead is needed.

Squashfs is available from http://squashfs.sourceforge.net.

The patch file is currently against 2.4.19.  There is further info on 
the filesystem design etc. in the README.

I'l be interested in getting any feedback, advice etc. on it.

Phill Lougher

