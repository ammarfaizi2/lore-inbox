Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269416AbUJLBNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269416AbUJLBNf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 21:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266888AbUJLBK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 21:10:57 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:42592 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S269404AbUJLBFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 21:05:05 -0400
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: akpm@osdl.org
Subject: [patch 0/17] UML updates, which must be merged before 2.6.9
Date: Tue, 12 Oct 2004 03:05:24 +0200
User-Agent: KMail/1.6.1
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410120305.24675.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, sorry for sending these patches so late, but they are (mostly 
one-liners) needed to fix either warnings in compilation (the patches are 
safe) or probable bugs which are created by these warnings.

The Makefile patch are of another kind: actually, when I send that couple of 
patches merged before -rc3, they were against my tree and absolutely 
incorrect against Linus tree; sorry for not checking that; in fact UML does 
not link with neither -rc3 nor -rc4 (also due to a compilation bug I already 
fixed for -rc3). However, this Makefile fixes fix everything, have been 
longly tested in public (hanging both in my tree, in SuSE UML tree and in 
Jeff Dike's tree).

Finally, I'm sending a patch for a network corruption which is very nasty; 
it's a one-liner, a resync against the copied original code and I've actually 
tested it works perfectly.

So, please, even if now we are in a hurry after -rc4, merge them. It's the 
only possibility for UML to actually work "out of the box".

Oh well, and sorry for sending "[uml-devel] [patch 4/6] uml: don't declare 
cpu_online - fix compilation error" - I just noticed it's included in 
2.6.9-rc4-mm1. All the rest applies without even any offsets to that tree, 
too.

Thanks a lot for your help.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
