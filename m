Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312643AbSDKRht>; Thu, 11 Apr 2002 13:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312675AbSDKRhs>; Thu, 11 Apr 2002 13:37:48 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:2574 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S312643AbSDKRhq>; Thu, 11 Apr 2002 13:37:46 -0400
Date: Thu, 11 Apr 2002 14:37:23 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove compiler.h from mmap.c
Message-ID: <Pine.LNX.4.44L.0204111436080.31387-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


compiler.h is included via other include files now and its
#include has been removed from most C files, this patch
finishes the job for mm/*

Rik
-- 
Will hack the VM for food.

http://www.surriel.com/		http://distro.conectiva.com/


diff -Nru a/mm/mmap.c b/mm/mmap.c
--- a/mm/mmap.c Thu Apr 11 14:21:58 2002
+++ b/mm/mmap.c Thu Apr 11 14:21:58 2002
@@ -14,7 +14,6 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/personality.h>
-#include <linux/compiler.h>

 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>


