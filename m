Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278661AbRJ1UiL>; Sun, 28 Oct 2001 15:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278662AbRJ1UiB>; Sun, 28 Oct 2001 15:38:01 -0500
Received: from [213.97.199.90] ([213.97.199.90]:4224 "HELO fargo")
	by vger.kernel.org with SMTP id <S278661AbRJ1Uho> convert rfc822-to-8bit;
	Sun, 28 Oct 2001 15:37:44 -0500
From: "David =?ISO-8859-1?Q?G=F3mez" ?= <davidge@jazzfree.com>
Date: Sun, 28 Oct 2001 22:34:46 +0100 (CET)
X-X-Sender: <huma@fargo>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] docbook documentation
Message-ID: <Pine.LNX.4.33.0110282231320.2263-100000@fargo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, this patch fix an error when generating postscript files. Error is
caused by the absence of documentation in include/asm/io.h.

--- deviceiobookold.tmpl	Sun Oct 28 22:28:36 2001
+++ deviceiobook.tmpl	Sun Oct 28 22:28:45 2001
@@ -224,9 +224,5 @@

   </chapter>

-  <chapter id="pubfunctions">
-     <title>Public Functions Provided</title>
-  !Einclude/asm-i386/io.h
-  </chapter>

 </book>


David Gómez

"The question of whether computers can think is just like the question of
 whether submarines can swim." -- Edsger W. Dijkstra


