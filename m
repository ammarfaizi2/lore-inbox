Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135987AbRD0HKb>; Fri, 27 Apr 2001 03:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135990AbRD0HKV>; Fri, 27 Apr 2001 03:10:21 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:55562 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S135987AbRD0HKJ>;
	Fri, 27 Apr 2001 03:10:09 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200104270708.f3R78Sd195521@saturn.cs.uml.edu>
Subject: Re: [PATCH] Single user linux
To: imel96@trustix.co.id
Date: Fri, 27 Apr 2001 03:08:28 -0400 (EDT)
Cc: moffe@amagerkollegiet.dk (=?iso-8859-1?Q?Rasmus_B=F8g_Hansen?=),
        johnc@damncats.org (John Cavan), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0104262026140.1816-100000@tessy.trustix.co.id> from "imel96@trustix.co.id" at Apr 26, 2001 09:03:40 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

imel96@trustix.co. writes:

> i wrote somewhere that it was my mistake to call it single-user when i
> mean all user has the same root cap, and reduce "user" (account) to
> "profile".

Seen this way it makes a tad more sense:

1. you and your spouse share the computer
2. you have different shells, mail folders, etc.
3. both of you are too lazy to use su or sudo

It isn't really bright having UID 0 have properties that can't
sanely be granted to other UIDs. Sure, we have the capability
bits, but just try using them. On the "would be nice" list goes
the ability to grant capabilities to a user, and the Novell-like
ability to grant one user complete access to the files of
another user without mucking with the permission bits on disk.

