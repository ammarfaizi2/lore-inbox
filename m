Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131092AbQK2M0S>; Wed, 29 Nov 2000 07:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131246AbQK2M0I>; Wed, 29 Nov 2000 07:26:08 -0500
Received: from u-code.de ([207.159.137.250]:11993 "EHLO u-code.de")
        by vger.kernel.org with ESMTP id <S131092AbQK2MZ4>;
        Wed, 29 Nov 2000 07:25:56 -0500
From: Eckhard Jokisch <e.jokisch@u-code.de>
Reply-To: e.jokisch@u-code.de
Organization: u-code
To: Jean-Luc Fontaine <jfontain@winealley.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4 test10 error reading from HP colorado 7/14 Gb tape
Date: Wed, 29 Nov 2000 12:50:34 +0000
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <3A24DDD1.D4731F6C@winealley.com>
In-Reply-To: <3A24DDD1.D4731F6C@winealley.com>
MIME-Version: 1.0
Message-Id: <00112912565800.21358@eckhard>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> # tar -tvf  /dev/ht0
> ide-tape: ht0: I/O error, pc = 8, key = 5, asc = 2c, ascq = 0
> 
> A search on deja.com shows that I am not the only one to have
> experienced this and that it did not occur with previous versions of
> ide-tape.c. The same error occurs with a non-modular kernel build.
> 
I experience the same with OnStream DI30 - but these errors occure in 2.2.17 as
well. In my oppinion they show up in fewer cases with 2.4-test10. 
The error is not quite"stable" because it occures on different tape positions
(filenames) when I retension the tape three aor four times befor writing to it.

I checked the tapes on a Windows machine and they seem to be o.k..

Eckhard Jokisch
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
