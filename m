Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130648AbQKKNuy>; Sat, 11 Nov 2000 08:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130791AbQKKNuo>; Sat, 11 Nov 2000 08:50:44 -0500
Received: from limes.hometree.net ([194.231.17.49]:26912 "EHLO
	limes.hometree.net") by vger.kernel.org with ESMTP
	id <S130760AbQKKNud>; Sat, 11 Nov 2000 08:50:33 -0500
To: linux-kernel@vger.kernel.org
Date: Sat, 11 Nov 2000 13:20:32 +0000 (UTC)
From: "Henning P. Schmiedehausen" <hps@tanstaafl.de>
Message-ID: <8ujh30$1nj$1@forge.tanstaafl.de>
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
In-Reply-To: <3A0C4252.100D863D@timpanogas.org>
Reply-To: hps@tanstaafl.de
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in /var/spool/mqueue]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jmerkey@timpanogas.org (Jeff V. Merkey) writes:

>The sendmail folks are claiming that the TCPIP stack in Linux is broken,
>which is what they claim is causing problems on sendmail on Linux
>platforms.  Before anyone says, "don't use that piece of shit sendmail,
>use qmail instead", perhaps we should look at this problem and refute
>these statements -- I think that sendmail is causing this problem.  The
>version is sendmail 8.9.3

>I can reproduce this bug on RH6.2, RH7.0, Caldera 2.2, 2.3, and 2.4,
>Suse 6.X versions, and any of these distributions with the following
>kernels.   

>2.2.14, 2.2.16, 2.2.17, 2.2.18, 2.4.0 (all).  What happens is that
>sendmail fails to forward mails with any attachments larger than 400K,
>and they just sit in the /var/spool/mqueue directory for up to a week,
>and eventually get delivered.

Jeff,

I run about three dozen sendmail server boxes (8.9.3 to 8.11.1) on all
these platforms and each one of these boxes transfer 1,000,000+ Mails
per week (yes, this is one million).

There is _no_ _such_ _bug_. Maybe you get bitten by some bogus traffic
shapers (you did read the report from Wietse, didn't you). If there
would be such a bug, I believe, that any of the 10,000+ Customers
would start complaining.

But there is no problem with mails in any size and sendmail on Linux.

And I'm pretty much annoyed that you try to use this list not as a
kernel but a general linux-support list, because you drag every single
problem that may be far out related to a kernel, because it runs on a
kernel into this list.

Pay some $$$ for professional tech support. And use this list as a
kernel development list. Not some "I have no idea but I am a Netware
buff that has some money, so you have to listen to me or I will strike
you with my anger" rant list.

	End of discussion
		Henning
-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
