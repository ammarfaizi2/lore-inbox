Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129028AbRBFLXQ>; Tue, 6 Feb 2001 06:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129027AbRBFLXH>; Tue, 6 Feb 2001 06:23:07 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:11531 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129026AbRBFLW5>; Tue, 6 Feb 2001 06:22:57 -0500
Subject: Re: [reiserfs-list] mongo.sh 2.2.18: do_try_to_free_pages failed
To: solics@icafe.ro
Date: Tue, 6 Feb 2001 11:22:22 +0000 (GMT)
Cc: wenzhuo@zhmail.com (Wenzhuo Zhang), reiserfs-list@namesys.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0102061140530.16736-100000@mail.icafe.ro> from "solics@icafe.ro" at Feb 06, 2001 11:41:56 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Q6CX-0005Ok-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is a bad RAM problem, or insufficient RAM (slightly less possible)

Unlikely to be either of those. My guess is its the reiserfs stuff interacting
with the 2.2 VM code badly. 2.2.19pre8 fixes the VM behaviour in the general
case and that might well make it handle the extra vm pressure reiserfs causes

Certainly I'd try 2.2.19pre3 or higher. I don't think its hardware or
reiserfs problems




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
