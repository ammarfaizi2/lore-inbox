Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271866AbRHUVGt>; Tue, 21 Aug 2001 17:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271864AbRHUVGj>; Tue, 21 Aug 2001 17:06:39 -0400
Received: from athena.intergrafix.net ([206.245.154.69]:6071 "HELO
	athena.intergrafix.net") by vger.kernel.org with SMTP
	id <S271866AbRHUVG2>; Tue, 21 Aug 2001 17:06:28 -0400
Date: Tue, 21 Aug 2001 17:06:42 -0400 (EDT)
From: Admin Mailing Lists <mlist@intergrafix.net>
To: linux-kernel@vger.kernel.org
Subject: directory walking faster on 2.4.8-ac8?
Message-ID: <Pine.LNX.4.10.10108211700160.17144-100000@athena.intergrafix.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I deleted the last message in the mentioned thread, but I tried out
2.4.8-ac8 and directory walking didn't seem any faster than 2.4.4 (unless
there are special circumstances)?

ls -l <dir> | wc -l

2.4.8-ac8:
directory with 1336 subdirectories underneath: 13 secs
 915: 8  secs
 795: 8  secs
 336: 3  secs

2.4.4:
1336: 12 secs
 915: 8  secs
 795: 11 secs
 336: 3  secs

am i missing something?
AIC7880 onboard, Quantum Viking 4.5, 40MB/S
SMP PPro200s, 128MB RAM

-Tony
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.
Anthony J. Biacco                       Network Administrator/Engineer
thelittleprince@asteroid-b612.org       Intergrafix Internet Services

    "Dream as if you'll live forever, live as if you'll die today"
http://www.asteroid-b612.org                http://www.intergrafix.net
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.


