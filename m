Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRABQnQ>; Tue, 2 Jan 2001 11:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbRABQm4>; Tue, 2 Jan 2001 11:42:56 -0500
Received: from csa.iisc.ernet.in ([144.16.67.8]:2571 "EHLO csa.iisc.ernet.in")
	by vger.kernel.org with ESMTP id <S129511AbRABQmn>;
	Tue, 2 Jan 2001 11:42:43 -0500
Date: Tue, 2 Jan 2001 21:40:49 +0530 (IST)
From: Sourav Sen <sourav@csa.iisc.ernet.in>
To: lkml <linux-kernel@vger.kernel.org>
Subject: iph
Message-ID: <Pine.SOL.3.96.1010102213630.23276A-100000@kohinoor.csa.iisc.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	I want to know what the field, ihl in the struct iphdr is there
for, I mean its function and the values it takes in different condition.
Specifically, what is the condition when ihl>5.

(See ip_input.c , line 497, depending on if ihl>5, some code is getting
executed.)

I am talking of 2.2.16

Sourav

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
