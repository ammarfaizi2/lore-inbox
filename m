Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271666AbRHUNnG>; Tue, 21 Aug 2001 09:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271667AbRHUNm5>; Tue, 21 Aug 2001 09:42:57 -0400
Received: from wildsau.idv-edu.uni-linz.ac.at ([140.78.40.25]:30993 "EHLO
	wildsau.idv-edu.uni-linz.ac.at") by vger.kernel.org with ESMTP
	id <S271666AbRHUNmn>; Tue, 21 Aug 2001 09:42:43 -0400
From: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>
Message-Id: <200108211342.f7LDgo829400@wildsau.idv-edu.uni-linz.ac.at>
Subject: min/max breaks numerous software
To: linux-kernel@vger.kernel.org
Date: Tue, 21 Aug 2001 15:42:49 +0200 (MET DST)
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

2.4.9 three-eyed min/max declarations breaks e.g. latest
pcmcia-cs-3.1.28 from pcmcia.sourceforge.org.

after #undef min/max in one file, compilation would fail in the
next file. so, instead of changing min/max occurences in pcmcia-cs,
I #if-0ed it in <linux/kernel.h>

please lets get rid of that ugly declarations. if we indeed need typed
min/max, let's choose a different name for it then.

/herp

