Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315472AbSFOTcr>; Sat, 15 Jun 2002 15:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315479AbSFOTcq>; Sat, 15 Jun 2002 15:32:46 -0400
Received: from smtp02do.de.uu.net ([192.76.144.69]:25331 "EHLO
	smtp02do.de.uu.net") by vger.kernel.org with ESMTP
	id <S315472AbSFOTcq>; Sat, 15 Jun 2002 15:32:46 -0400
From: Ulrich Pfeifer <pfeifer@wait.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.17: Cramfs fixes + mtime
In-Reply-To: <p5r8jfshpd.fsf@hentai.de.uu.net>
Date: 15 Jun 2002 21:32:42 +0200
Message-ID: <p5u1o4qqw5.fsf@hentai.de.uu.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

some more work on the cramfs patch:

+ mkcramfs can detect hard linked files again.  Duplicate files are
  not detected - I don't think that is of much use.

+ support for uncompressed files fixed.  Did not work to reliable
  before.

+ added a flag (-a 0.95) to mkcramfs to automatically XIP files (store
  them uncompressed) if the compression ration is below the specified
  limit.

Here is the patch:

  http://www.wait.de/agenda/cramfs+mtime-2.4.17.patch-2.gz (16k)

This time the URL does really work.

Ulrich Pfeifer
