Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130509AbQLZAqp>; Mon, 25 Dec 2000 19:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131129AbQLZAq0>; Mon, 25 Dec 2000 19:46:26 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:47883 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S130509AbQLZAqW>;
	Mon, 25 Dec 2000 19:46:22 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200012260015.eBQ0FJk41580@saturn.cs.uml.edu>
Subject: Re: About Celeron processor memory barrier problem
To: timw@splhi.com
Date: Mon, 25 Dec 2000 19:15:19 -0500 (EST)
Cc: kaih@khms.westfalen.de (Kai Henningsen), torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20001224125023.A1900@scutter.internal.splhi.com> from "Tim Wright" at Dec 24, 2000 12:50:23 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Wright writes:

> There was a similar thread to this recently. The issue is that if you
> choose the wrong processor type, you may not even be able to complain.

An illegal opcode handler could deal with the problem.
It could crudely emulate just enough to make printk work.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
