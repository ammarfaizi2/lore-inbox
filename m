Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132904AbRALAJy>; Thu, 11 Jan 2001 19:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135434AbRALAJo>; Thu, 11 Jan 2001 19:09:44 -0500
Received: from femail1.rdc1.on.home.com ([24.2.9.88]:22728 "EHLO
	femail1.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S132904AbRALAJc>; Thu, 11 Jan 2001 19:09:32 -0500
Message-ID: <3A5E4B1D.5EF1B0EB@Home.net>
Date: Thu, 11 Jan 2001 19:09:01 -0500
From: Shawn Starr <Shawn.Starr@Home.net>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Critical compile bug: 2.4.1-pre2 alpha
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

init/main.o: In function `check_fpu':
init/main.o(.text.init+0x53): undefined reference to
`__buggy_fxsr_alignment'
make: *** [vmlinux] Error 1

On compiling (and recompiling) i get this fatal error. This function
does not exist anymore?

Shawn Starr.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
