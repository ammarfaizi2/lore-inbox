Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317652AbSFRWkG>; Tue, 18 Jun 2002 18:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317653AbSFRWkF>; Tue, 18 Jun 2002 18:40:05 -0400
Received: from fmr04.intel.com ([143.183.121.6]:19679 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S317652AbSFRWkD>; Tue, 18 Jun 2002 18:40:03 -0400
Message-Id: <200206182239.g5IMdrP04770@unix-os.sc.intel.com>
Content-Type: text/plain; charset=US-ASCII
From: mgross <mgross@unix-os.sc.intel.com>
Reply-To: mgross@unix-os.sc.intel.com
Organization: SSG Intel
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] TCore patch for 2.5.22
Date: Tue, 18 Jun 2002 15:47:14 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Linus Torvalds <torvalds@transmeta.com>, mark.gross@intel.com
References: <200206142310.g5ENADP23772@unix-os.sc.intel.com>
In-Reply-To: <200206142310.g5ENADP23772@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attached is a re-base to the 2.5.22 kernel of the patch posted last week.  It 
also includes the clean up suggested by Vamsi Krishna.

This patch has been tested on my SMP system and is stable.
I would like very much to see this feature added to the 2.5.x kernels and
more milage given to it.

To use the core files from multi-threaded applications, created with this
patch you may need to strip the objects from /lib/libpthread. For my system
'strip /lib/libpthread-0.9.so makes things good, YMMV.

Please apply this patch.

--mgross

