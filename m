Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312987AbSEEOyq>; Sun, 5 May 2002 10:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313014AbSEEOyq>; Sun, 5 May 2002 10:54:46 -0400
Received: from jagor.srce.hr ([161.53.2.130]:44744 "EHLO jagor.srce.hr")
	by vger.kernel.org with ESMTP id <S312987AbSEEOyp>;
	Sun, 5 May 2002 10:54:45 -0400
Message-Id: <200205051454.g45EsM89006510@jagor.srce.hr>
Content-Type: text/plain; charset=US-ASCII
From: Danijel Schiavuzzi <dschiavu@public.srce.hr>
Organization: Dead Poets Society
To: linux-kernel@vger.kernel.org
Subject: Kernel patching 2.4.19pre1 -> 2.4.19pre2
Date: Sun, 5 May 2002 16:54:39 +0200
X-Mailer: KMail [version 1.3.1]
X-UIN: 39223454
X-Operating-System: GNU/Linux 2.4.17
X-Troll: no
X-URL: <http://danijels.cjb.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I'm trying to patch a 2.4.17 clean source tree to the latest 2.4.19-pre8 tree.
I can patch it until the 2.4.19pre1.
When I try to apply patch-2.4.19pre2.bz2, this happens:

wolf:/usr/src# patch -p0 < patch-2.4.19-pre2
patching file `linux/COPYING'
patching file `linux/CREDITS'
patching file `linux/Documentation/Changes'
patching file `linux/Documentation/Configure.help'
Hunk #2 succeeded at 4810 with fuzz 2 (offset 7 lines).
Hunk #3 succeeded at 6420 with fuzz 2 (offset 12 lines).
Hunk #4 succeeded at 12716 (offset 7 lines).
Hunk #5 succeeded at 14736 (offset 12 lines).
Hunk #6 succeeded at 14751 (offset 7 lines).
Hunk #7 succeeded at 17670 (offset 12 lines).
Hunk #8 FAILED at 19021.
1 out of 8 hunks FAILED -- saving rejects to 
linux/Documentation/Configure.help.rej
patching file `linux/Documentation/DocBook/Makefile'
patching file `linux/Documentation/DocBook/kernel-api.tmpl'
patching file `linux/Documentation/cciss.txt'
Reversed (or previously applied) patch detected!  Assume -R? [n]

I re-downloaded patch-2.4.19pre1.bz2 and tried again with the same results.
Where's the problem?
I'm using Debian 2.2 (Potato).

-- 
Danijel Schiavuzzi
