Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAEVlE>; Fri, 5 Jan 2001 16:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129790AbRAEVky>; Fri, 5 Jan 2001 16:40:54 -0500
Received: from mercury.eng.emc.com ([168.159.40.77]:55053 "EHLO
	mercury.lss.emc.com") by vger.kernel.org with ESMTP
	id <S129183AbRAEVkt>; Fri, 5 Jan 2001 16:40:49 -0500
Message-ID: <276737EB1EC5D311AB950090273BEFDD979E4C@elway.lss.emc.com>
From: "chen, xiangping" <chen_xiangping@emc.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: boot up problem 
Date: Fri, 5 Jan 2001 16:31:38 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Folks

Another problem I meet in boot up is that the root filesystem
can be mount as readonly at first, but it fails to be mounted 
as read/write during boot up, the error reported as:
	The superblock can not be read or does not describe a correct
	ext2 filesystem. ...

	fsck.ext2 no such file or directory when trying to open LABEL=/

When I tried to fix it using fsck, it reports clean.

But the original root filesystem still exists, I can still boot up
using kernel image 2.2.16-22.	

Any help is greatly appreciated!

Xiangping
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
