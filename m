Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLGMNs>; Thu, 7 Dec 2000 07:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129707AbQLGMNi>; Thu, 7 Dec 2000 07:13:38 -0500
Received: from mailgate.ics.forth.gr ([139.91.1.2]:32973 "EHLO
	ext1.ics.forth.gr") by vger.kernel.org with ESMTP
	id <S129183AbQLGMNZ>; Thu, 7 Dec 2000 07:13:25 -0500
Posted-Date: Thu, 7 Dec 2000 13:41:41 +0200 (EET)
Organization: 
Date: Thu, 7 Dec 2000 13:42:13 +0200 (EET)
From: Kotsovinos Vangelis <kotsovin@ics.forth.gr>
To: linux-kernel@vger.kernel.org
cc: Kotsovinos Vangelis <kotsovin@ics.forth.gr>
Subject: Microsecond accuracy
Message-ID: <Pine.GSO.4.10.10012071337530.7874-100000@athena.ics.forth.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is there any way to measure (with microsecond accuracy) the time of a
program execution (without using Machine Specific Registers) ?
I've already tried getrusage(), times() and clock() but they all have
10 millisecond accuracy, even though they claim to have microsecond
acuracy.
The only thing that seems to work is to use one of the tools that measure
performanc through accessing the machine specific registers. They give you
the ability to measure the clock cycles used, but their accuracy is also
very low from what I have seen up to now.

Thank you very much in advance

--) Vangelis

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
