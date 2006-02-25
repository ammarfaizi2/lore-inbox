Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWBYQYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWBYQYR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 11:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964774AbWBYQYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 11:24:17 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:34791 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964773AbWBYQYQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 11:24:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=D0e0+zFuk6fA/Qku5T0lqW2k/coVigmCtSyT32IgQB/wDZHXq6aaahAqHvXtOCJk4w8RnlAE7hKK3etTpXS9R6rcqtclkPdOrm/wp8k+wLWGT59tkorJS3Bi2H8Eeg2AiSGHZ2kLGLfkzoRhbqHBaAa/DzAfNLBLPbhDC1Uj0oQ=
Message-ID: <9a8748490602250824u34e664fandc56c20394367926@mail.gmail.com>
Date: Sat, 25 Feb 2006 17:24:10 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Andrew Veliath" <andrewtv@usa.net>
Subject: OSS msnd build failure
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During some build tests of 2.6.16-rc4-mm2 with  'make randconfig'  I
found this build failure :

  ...
  LD      drivers/built-in.o
  CC      sound/sound_core.o
  CC      sound/sound_firmware.o
  CC      sound/oss/msnd.o
make[2]: *** No rule to make target `/etc/sound/msndperm.bin', needed
by `sound/oss/msndperm.c'.  Stop.
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [sound/oss] Error 2
make: *** [sound] Error 2

I must admit I don't know how to fix it, so I'll have to just report it.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
