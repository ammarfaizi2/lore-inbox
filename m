Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbVCIEXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVCIEXX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 23:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVCIEXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 23:23:23 -0500
Received: from smtp100.rog.mail.re2.yahoo.com ([206.190.36.78]:9643 "HELO
	smtp100.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261594AbVCIEXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 23:23:17 -0500
Subject: [PATCH][Documentation update]Re: diff command line?
From: John Kacur <jkacur@rogers.com>
Reply-To: jkacur@rogers.com
To: Jim Nelson <james4765@cwazy.co.uk>
Cc: linux-kernel@vger.kernel.org, rddunlap@osdl.org
In-Reply-To: <4229E219.20100@cwazy.co.uk>
References: <200503051048.00682.gene.heskett@verizon.net>
	 <20050305161822.H3282@flint.arm.linux.org.uk>  <4229E219.20100@cwazy.co.uk>
Content-Type: text/plain
Message-Id: <1110342199.5533.24.camel@linux.site>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 08 Mar 2005 23:23:19 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-03-05 at 11:45, Jim Nelson wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Russell King wrote:
> | On Sat, Mar 05, 2005 at 10:48:00AM -0500, Gene Heskett wrote:
> |
> |>What are the options normally used to generate a diff for public
> |>consumption on this list?
> |
> |
> | diff -urpN orig new
> |
> | where "orig" and "new" both contain the top level "linux" directory,
> | so the resulting patch can be applied with patch -p1.
> |
> 
> You'd also want to add "-x dontdiff", using
> 
> http://developer.osdl.org/rddunlap/scripts/dontdiff-osdl
> 
> That way, you can do a diff, even if you have run a compile in one of the
> directory trees.

Hey, why isn't that is the documentation? I didn't hear of it until now.
Is this what most developers are using for 2.6, if so then we need the
following trivial documentation update. Created against the Docs in
2.6.11

--- SubmittingPatches.orig      2005-03-08 23:09:19.496223848 -0500
+++ SubmittingPatches   2005-03-08 23:18:52.192160832 -0500
@@ -60,6 +60,9 @@
 the build process, and should be ignored in any diff(1)-generated
 patch.  dontdiff is maintained by Tigran Aivazian <tigran@veritas.com>

+For 2.6 kernels you can fetch dontdiff-osdl maintained by Randy Dunlap.
+wget http://developer.osdl.org/rddunlap/scripts/dontdiff-osdl
+





