Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265394AbRFVM2G>; Fri, 22 Jun 2001 08:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265392AbRFVM1z>; Fri, 22 Jun 2001 08:27:55 -0400
Received: from pat.uio.no ([129.240.130.16]:64455 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S265391AbRFVM1p>;
	Fri, 22 Jun 2001 08:27:45 -0400
MIME-Version: 1.0
Message-ID: <15155.14779.124958.686172@charged.uio.no>
Date: Fri, 22 Jun 2001 14:27:39 +0200
To: Alexander Viro <viro@math.psu.edu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][RFC] inode->u.nfs_i allocated separately
In-Reply-To: <Pine.GSO.4.21.0106220234370.1959-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0106220234370.1959-100000@weyl.math.psu.edu>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Alexander Viro <viro@math.psu.edu> writes:

     > 	Trond, could you review the patch below? I believe that it's
     > 	OK
     > wrt races around iget(), but I'd appreciate if you take a look
     > at it.

It certainly doesn't suffer from the problem I raised last time, so at
first glance, I'd say it's OK. I'll see if I can't dig up some dirt on
it over the weekend though ;-).

Cheers,
  Trond
