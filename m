Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317035AbSGHR1R>; Mon, 8 Jul 2002 13:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317036AbSGHR1Q>; Mon, 8 Jul 2002 13:27:16 -0400
Received: from mons.uio.no ([129.240.130.14]:25252 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S317035AbSGHR1P>;
	Mon, 8 Jul 2002 13:27:15 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Organization: Dept. of Physics, University of Oslo, Norway
To: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: New package of beta-level NFS client updates out for 2.4.19-rc1
Date: Mon, 8 Jul 2002 19:29:43 +0200
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200207081929.43742.trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

  There's a new NFS_ALL package full of NFS client updates out for 2.4.19-rc1.
New features include:

  - UDP message round trip timing in order to improve the timeout + resend 
cycle.
  - UDP congestion control as per Van Jacobson.
  - Further improvements to the close-to-open code
  - Full support for the NFSv3 ACCESS function (as required by people who want 
to use ACLs).

A full description of all the components and features can be found in the file

   http://www.fys.uio.no/~trondmy/src/2.4.19-rc1/HEADER.html

the patch itself can be found as

  http://www.fys.uio.no/~trondmy/src/2.4.19-rc1/linux-2.4.19-NFS_ALL.dif

For those who have been following the contents of these files, please note 
that a lot of changes have been made w.r.t. the 2.4.18 version:
Amongst other things, the 'ping' patch (see 
http://www.fys.uio.no/~trondmy/src/2.4.18/HEADER.html) is assumed to be 
replaced by the new and improved RPC round trip timing+congestion avoidance 
code.
The DIRECTIO patch has been removed pending a decision by Chuck on whether or 
not he wants to continue supporting it?

Happy testing,
  Trond
