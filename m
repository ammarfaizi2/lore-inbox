Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269143AbRGaBWE>; Mon, 30 Jul 2001 21:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269141AbRGaBVy>; Mon, 30 Jul 2001 21:21:54 -0400
Received: from rj.SGI.COM ([204.94.215.100]:26601 "EHLO rj.corp.sgi.com")
	by vger.kernel.org with ESMTP id <S269140AbRGaBVv>;
	Mon, 30 Jul 2001 21:21:51 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [CFT] initramfs patch 
In-Reply-To: Your message of "Mon, 30 Jul 2001 17:56:25 EST."
             <Pine.LNX.3.96.1010730175545.27870C-100000@mandrakesoft.mandrakesoft.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 31 Jul 2001 11:21:38 +1000
Message-ID: <31687.996542498@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 30 Jul 2001 17:56:25 -0500 (CDT), 
Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
>Eventually I would like to see firmware uploading in initramfs,
>instead of compiling firmware images into the kernel...

<AOL>Me too</AOL>.  Building the firmware images as part of kbuild is
wrong, they should be in separate user space packages.  One of my
biggest problems with kbuild 2.5 was supporting the firmware build for
sound and SCSI cards in the kernel, it is all ugly special case code.

