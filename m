Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbVEIXVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVEIXVj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 19:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVEIXVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 19:21:38 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:20621 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261354AbVEIXV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 19:21:27 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: akpm@osdl.org
Subject: [patch 0/6] latest bugfixes for 2.6.12
Date: Tue, 10 May 2005 01:10:15 +0200
User-Agent: KMail/1.8
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505100110.16920.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some more fixes intended for 2.6.12 (and well tested). Can you merge 
them soon, Andrew? Thanks.

The first is a particularly bad one since it shows up when you *start* 
compiling UML (due to a quilt patch -> normal patch conversion problem, a 
file wasn't actually deleted, but it was when applied through quilt). Was 
this too quick a merge, maybe? What's your "merging policy" (if any) for 
patches?

Also, I had marked some of the patches I sent as needing some staging time in 
-mm (especially "uml: redo console locking"), while I had marked other ones 
as needing immediate merge. Jeff instead has sent some "cleanup / groundwork 
for future work" (which anyway were mostly trivial) together with some urgent 
fixes.

Actually they aren't a problem (especially because UML has almost no support 
for SMP) however this policy risks breaking things.

We had the exactly opposite problem for 2.6.10 release - some important fixes 
which were sent by Jeff just before 2.6.10 release to be merged in it (but 
which weren't explicitly marked as such) were merged in 2.6.10-mm1.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

