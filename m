Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136212AbRAGR7n>; Sun, 7 Jan 2001 12:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136217AbRAGR7c>; Sun, 7 Jan 2001 12:59:32 -0500
Received: from hera.cwi.nl ([192.16.191.1]:10908 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S136212AbRAGR7Z>;
	Sun, 7 Jan 2001 12:59:25 -0500
Date: Sun, 7 Jan 2001 18:59:20 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200101071759.SAA146769.aeb@texel.cwi.nl>
To: BJerrick@easystreet.com, p_gortmaker@yahoo.com
Subject: Re: 500 ms offset in i386 Real Time Clock setting
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't have a problem with the rtc driver delaying 500ms

I still haven't looked at things, but two points:
(i) is the behaviour constant on all architectures?
(ii) instead of waiting, isn't it much easier to redefine
what it means to access rtc?
(If you read a certain value then on average you are halfway
that second; if you write a certain value you are precisely
halfway that second. Maybe no delays are needed or desired.)

Andries

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
