Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131116AbQLUT6W>; Thu, 21 Dec 2000 14:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131132AbQLUT6M>; Thu, 21 Dec 2000 14:58:12 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:41995 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S131116AbQLUT6I>;
	Thu, 21 Dec 2000 14:58:08 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200012211927.eBLJROd347633@saturn.cs.uml.edu>
Subject: Re: kapm-idled : is this a bug?
To: pavel@suse.cz (Pavel Machek)
Date: Thu, 21 Dec 2000 14:27:24 -0500 (EST)
Cc: maillist@chello.nl (Igmar Palsenberg), pavel@ucw.cz (Pavel Machek),
        linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <20001221132800.A1398@bug.ucw.cz> from "Pavel Machek" at Dec 21, 2000 01:28:00 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Agree that it is different. But it confuses people to have two
>> idle-tasks. I suggest that we throw it one big pile, unless having a
>> separate apm idle task has a purpose. 
>
> You can't do that.

Sure you can, and it makes perfect sense.

> Doing it this way is _way_ better for system
> stability, because kidle-apmd sometimes dies due to APM
> bug. kidle-apmd dying is recoverable error; swapper dieing is as fatal
> as it can be.

Good. Maybe the bugs will get fixed then. If the bugs are in
the BIOS or motherboard hardware, we can have a blacklist.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
