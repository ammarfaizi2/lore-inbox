Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282508AbRL1Qlg>; Fri, 28 Dec 2001 11:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282547AbRL1Ql1>; Fri, 28 Dec 2001 11:41:27 -0500
Received: from cabal.xs4all.nl ([213.84.101.140]:31934 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id <S282508AbRL1QlP>;
	Fri, 28 Dec 2001 11:41:15 -0500
Date: Fri, 28 Dec 2001 17:41:11 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org, linux-hams@vger.kernel.org
Subject: link error in SCC driver
Message-ID: <20011228164111.GK7481@wiggy.net>
Mail-Followup-To: Wichert Akkerman <wichert@wiggy.net>,
	linux-kernel@vger.kernel.org, linux-hams@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I compile a kernel with a recent binutils and the scc driver
I get the now famous linking error:

net/network.o(.text.lock+0x2b38): undefined reference to `local symbols
in discarded section .text.exit'

Stock 2.4.17 kernel source, GNU ld version 2.11.92.0.12.3 20011121.

Wichert.

-- 
  _________________________________________________________________
 /wichert@wiggy.net         This space intentionally left occupied \
| wichert@deephackmode.org            http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |
