Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269116AbUHaW1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269116AbUHaW1s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 18:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268484AbUHaW0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 18:26:16 -0400
Received: from advect.atmos.washington.edu ([128.95.89.50]:56754 "EHLO
	advect.atmos.washington.edu") by vger.kernel.org with ESMTP
	id S268458AbUHaWVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 18:21:22 -0400
Message-Id: <200408312221.i7VMLHPu007234@moist.atmos.washington.edu>
Date: Tue, 31 Aug 2004 15:21:17 -0700 (PDT)
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re[4]: PROBLEM: page allocation or what in 2.6.8.1
From: Harry Edmon <harry@atmos.washington.edu>
In-Reply-To: <20040831120232.18dfa3c0.akpm@osdl.org>
X-Mailer: Ishmail 2.1.0-20021115-i686-pc-linux-gnu <http://ishmail.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -15.214 () AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So far, no crash.  But now I have NFS clients that from time to time are unable
to access this server.  The server has the following messages on it:

Aug 31 15:16:43 funnel rpc.mountd: getfh failed: Operation not permitted

I can temporarily fix the problem by typing:

exportfs -ar

But eventually it happens again.

-- 
 Dr. Harry Edmon			E-MAIL: harry@atmos.washington.edu
 206-543-0547				harry@u.washington.edu
 Dept of Atmospheric Sciences		FAX:	206-543-0308
 University of Washington, Box 351640, Seattle, WA 98195-1640
