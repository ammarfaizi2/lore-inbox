Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131649AbRCOUtQ>; Thu, 15 Mar 2001 15:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131682AbRCOUtG>; Thu, 15 Mar 2001 15:49:06 -0500
Received: from t2.redhat.com ([199.183.24.243]:61173 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S131649AbRCOUtB>; Thu, 15 Mar 2001 15:49:01 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@redhat.com>
X-Accept-Language: en_GB
To: linux-kernel@vger.kernel.org, mtd@infradead.org
Reply-To: dwmw2@infradead.org
Subject: ANNOUNCE: Journalling Flash File System, v2. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 15 Mar 2001 18:03:24 +0000
Message-ID: <21916.984679404@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, it's been almost a week since the latest stupid bug was found in the 
JFFS2 code, so I suppose it's time to admit to the world that it exists.

JFFS2, developed by Red Hat, is a complete reimplementation of a 
journalling filesystem for FLASH devices, based on the original JFFS 
from Axis Communications AB. 

Improvements of JFFS2 over the original JFFS include:

	- Improved wear levelling and garbage collection performance.
	- Compression
	- Improved RAM footprint and response to system memory pressure.
	- Improved concurrency and support for suspending flash erases
	- Support for hard links.
	

You can get it from anonymous CVS:

cvs -d :pserver:anoncvs@cvs.infradead.org:/home/cvs login (password: anoncvs)
cvs -d :pserver:anoncvs@cvs.infradead.org:/home/cvs co mtd
    
The only platform currently supported is Linux 2.4. A port to eCos is 
likely to happen quite soon.

JFFS2 filesystem images of the current 'Familiar' distribution for the
Compaq iPAQ, along with appropriate kernels, are available at 
ftp://ftp.uk.linux.org/pub/people/dwmw2/familiar-0.3/

--
dwmw2


