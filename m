Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136145AbREGOm6>; Mon, 7 May 2001 10:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136148AbREGOms>; Mon, 7 May 2001 10:42:48 -0400
Received: from www.sinfopragma.it ([213.26.181.2]:30728 "EHLO
	sinfo-www-01.sinfopragma.it") by vger.kernel.org with ESMTP
	id <S136145AbREGOmj>; Mon, 7 May 2001 10:42:39 -0400
Date: Mon, 7 May 2001 16:46:46 +0200 (W. Europe Daylight Time)
From: Lorenzo Marcantonio <lorenzo.marcantonio@sinfopragma.it>
To: <linux-kernel@vger.kernel.org>
Subject: SCSI Tape corruption - update
Message-ID: <Pine.WNT.4.31.0105071638470.346-100000@pc209.sinfopragma.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As of my latest build [2.4.5-pre1] I've STILL got the tape corruption
problem. Some new facts:

(1) It happens only writing the tape (tried exchanging tapes with a
brand new Alpha Digital Tru64 box). I can read her tape, she can't read
my tape. Tried with GNU tar and gzip.

(2) I suppose it isn't fault of AIC7xxx driver (tried both new and old)

(3) Playing with block size doesn't help (even tried variable block
size)

What can I do? Can I set some kind of trace to pinpoint the problem (in
st.c, maybe?)

				-- Lorenzo Marcantonio


