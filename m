Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263218AbSJ1Jjd>; Mon, 28 Oct 2002 04:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263228AbSJ1Jjd>; Mon, 28 Oct 2002 04:39:33 -0500
Received: from daimi.au.dk ([130.225.16.1]:8877 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S263218AbSJ1Jjc>;
	Mon, 28 Oct 2002 04:39:32 -0500
Message-ID: <3DBD074D.9B59DED6@daimi.au.dk>
Date: Mon, 28 Oct 2002 10:45:49 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-17.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: __block_prepare_write: zeroing uptodate buffer!
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do I need to worry about this error message from the kernel?
I experienced this with 2.4.19-ac4, but looking in my log I
found a few more from long ago:

Mar 19 17:27:19 eddie kernel: __block_prepare_write: zeroing uptodate buffer!
Mar 19 17:27:58 eddie kernel: __block_prepare_write: zeroing uptodate buffer!
Mar 19 17:27:58 eddie kernel: __block_prepare_write: zeroing uptodate buffer!
May 12 21:45:53 eddie kernel: __block_prepare_write: zeroing uptodate buffer!
May 13 06:09:56 eddie kernel: __block_prepare_write: zeroing uptodate buffer!
May 13 06:13:43 eddie kernel: __block_prepare_write: zeroing uptodate buffer!
May 13 06:14:44 eddie kernel: __block_prepare_write: zeroing uptodate buffer!
Oct 28 09:14:54 eddie kernel: __block_prepare_write: zeroing uptodate buffer!

The messages has been seen with kernel versions 2.4.18,
2.4.19-pre8-ac1, and 2.4.19-ac4.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
Don't do this at home kids: touch -- -rf
