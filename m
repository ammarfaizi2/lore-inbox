Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263431AbTJLI1a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 04:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263432AbTJLI1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 04:27:30 -0400
Received: from smtp3.att.ne.jp ([165.76.15.139]:37548 "EHLO smtp3.att.ne.jp")
	by vger.kernel.org with ESMTP id S263431AbTJLI13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 04:27:29 -0400
Message-ID: <2bf201c3909a$98215330$5cee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <aj@dungeon.inka.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Why are bad disk sectors numbered strangely, and what happens to them?
Date: Sun, 12 Oct 2003 17:25:00 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Jellinghaus replied to me with useful advice.  But he didn't really
answer my questions.  Please, if anyone knows the answers to my questions,
please kindly say.
(Why the sectors were numbered so strangely,
what does Linux do with them after detecting them,
and how to know if the errors occured during writes or during reads.)

Anyway,

> try the smartmontools package, it has "smartctl" that will
> show you the discs S.M.A.R.T. details

Good idea, thank you.

> doing a backup couldn't hurt.

It's essentially my crash box at the moment.  But I didn't expect visible
errors on a 2-year-old disk.  (Of course the magnetic layer always has
errors but I didn't expect things to get beyond the firmware's automatic
assignment and writing of replacement sectors.)

And my reason for posting is that the error logs didn't look the way I would
have expected, regarding the sector numbers and the repetitions.

> btw: are you sure cables are ok?

1.  There are none.
2.  If the connector on the motherboard were coming loose from the
motherboard, or if the motherboard had a crack causing intermittent failures
in some of its connections, surely the I/O errors would be far more numerous
and far more random than the strange occurences I observed.

