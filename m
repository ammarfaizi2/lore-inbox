Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261751AbTCZPgK>; Wed, 26 Mar 2003 10:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261754AbTCZPgJ>; Wed, 26 Mar 2003 10:36:09 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:37561
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261751AbTCZPf7>; Wed, 26 Mar 2003 10:35:59 -0500
Subject: Re: Direck IO  on SCSI Disk
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Akhilesh <sony@innomedia.soft.net>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <3E81BB1B.3020007@innomedia.soft.net>
References: <3E81BB1B.3020007@innomedia.soft.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048698039.31839.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Mar 2003 17:00:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-26 at 14:37, Akhilesh wrote:
> more SCSI disks attached to it. In order to build our own filesystem  I 
> need to  do direct  writing/reading  in the SCSI disk bypassing all the 
> kernel level buffering. 
> 
> Could you please suggest some information as how to go about it.

A Linux file system doesn't have to use the page cache Linux provides, so 
in theory there is no reason it cannot be done. Two obvious examples to
look at are OCFS (oracle's GPL'd cluster fs) and OpenGFS (opengfs.sourceforge.net)

