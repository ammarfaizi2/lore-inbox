Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbUK1QPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbUK1QPd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 11:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbUK1QPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 11:15:33 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:39824 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261504AbUK1QPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 11:15:23 -0500
Subject: Re: [2.6 patch] small MCA cleanups (fwd)
From: James Bottomley <James.Bottomley@SteelEye.com>
To: David Weinehall <tao@acc.umu.se>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041124075932.GJ28432@khan.acc.umu.se>
References: <20041124020427.GM2927@stusta.de> 
	<20041124075932.GJ28432@khan.acc.umu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 28 Nov 2004 10:13:49 -0600
Message-Id: <1101658435.2426.5.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-24 at 01:59, David Weinehall wrote:
> Being waaaaaay to busy at work to care about MCA-related things anymore,
> combined with the fact that I didn't bring along any of my old
> MCA-machines when I moved the last time, I've asked James Bottomley to
> take over the MCA maintainership.
> 
> I don't have anything to object against these patches, but I'm not able
> to test them...

OK .. I said I'd do it, so here is the formal change of the maintainer. 
Note that I too only have a limited subset of MCA hardware ... the
voyager systems have a kind of super MCA bus that didn't have any of the
MCA bus limitations in the original IBM spec, so a lot of the MCA HW I
have doesn't work on ordinary MCA busses.  The only standard MCA cards I
have are networking ones.

James

--

Change MCA maintainer

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

===== MAINTAINERS 1.256 vs edited =====
--- 1.256/MAINTAINERS	2004-11-11 02:34:32 -06:00
+++ edited/MAINTAINERS	2004-11-28 10:09:19 -06:00
@@ -1451,11 +1451,8 @@
 S:	Maintained
 
 MISCELLANEOUS MCA-SUPPORT
-P:	David Weinehall
-M:	Project MCA Team <mcalinux@acc.umu.se>
-M:	David Weinehall <tao@acc.umu.se>
-W:	http://www.acc.umu.se/~tao/
-W:	http://www.acc.umu.se/~mcalinux/
+P:	James Bottomley
+M:	jejb@steeleye.com
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 

