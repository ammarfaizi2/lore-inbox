Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271907AbRIDISt>; Tue, 4 Sep 2001 04:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271909AbRIDISj>; Tue, 4 Sep 2001 04:18:39 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:55466 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S271907AbRIDIS0>;
	Tue, 4 Sep 2001 04:18:26 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15252.36364.884366.703245@harpo.it.uu.se>
Date: Tue, 4 Sep 2001 10:17:16 +0200
To: apm@csp.org.by
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: invalid depmod flag
In-Reply-To: <20010904105155.A8586@cyan>
In-Reply-To: <20010904105155.A8586@cyan>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Artiom Morozov writes:
 > during 
 > make modules_install
 > 
 > depmod fails because flags -F is invalid and should be replaced with -m
 > (imho!).
 > 
 > Kernel 2.4.6
 > depmod 2.1.121

You're using obsolete modutils. Kernel 2.4.6 requires modutils 2.4.2 or newer
(2.4.8 is the latest), as stated in the kernel's Documentation/Changes.
