Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267024AbUBMOfy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 09:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267033AbUBMOfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 09:35:54 -0500
Received: from gaia.di.uniba.it ([193.204.187.131]:51208 "EHLO
	gaia.di.uniba.it") by vger.kernel.org with ESMTP id S267024AbUBMOfv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 09:35:51 -0500
Date: Fri, 13 Feb 2004 15:35:42 +0100
From: "Angelo Dell'Aera" <buffer@antifork.org>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>,
       Michael Frank <mhf@linuxmail.org>
Subject: Re: PATCH, RFC: 2.6 Documentation/Codingstyle
Message-Id: <20040213153542.29686f0f.buffer@antifork.org>
In-Reply-To: <XFMail.20040213145513.pochini@shiny.it>
References: <20040213124232.B2871@pclin040.win.tue.nl>
	<XFMail.20040213145513.pochini@shiny.it>
Organization: Antifork Research, Inc.
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-PGP-Program: GNU Privacy Guard (http://www.gnupg.org)
X-PGP-PublicKey: http://buffer.antifork.org/privacy/buffer-gpg.asc
X-PGP-Fingerprint: 48CC B0D8 C394 CD30 355F E36D A4E3 48CF 19C1 5CA2
X-Operating-System: GNU-Linux
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Fri, 13 Feb 2004 14:55:13 +0100 (CET)
Giuliano Pochini <pochini@shiny.it> wrote:

>> The 80 here has a pedagogical and a practical purpose.
>> The practical one is that it makes sure that everybody can read the source.
>> The pedagogical is to invite you to arrange the code in a different way
>> if you are nesting too deeply or your expressions are too complicated.

>Deeply nested doesn't mean unreadable or badly structured.

I think you're really wrong since "deeply nested" means exactly "unreadable 
and badly structured" and you could easily realize it by simply spending ~10 
hours per day coding and/or taking a look at the code written by someone 
which is not you. A simple use of inline functions and a previous thinking 
about what you're going to write could easily solve all problems. 

>1 tab in the function, 1tab a switch, 1 if, 1 for, 1 if and you have already 
>lost half of the available space. It's not difficult to find lines compressed
>towards the 79th column in the kernel sources. I propose to change "hard limit" 
>to "soft limit" to avoid things like this:
>
>                                rc=idefloppy_begin_format(drive, inode,
>                                                              file,
>                                                              (int *)arg);

No one is saying this line of code is the best one could imagine... have you
ever thought that maybe anything "floating around" that code line could be 
written in a not-well structured way?

>IMO we should try to keep function calls on the same line. btw it's
>only a matter of taste and the compiler accepts ugly code too :))

A compiler should do it, a maintainer IMHO should not for a really simple 
reason: readability (which in most cases means maintainability too).

>> There is also ergonomics. There is a reason newspapers do not print
>> text across the full width of the page - it would be very difficult
>> to read.

>Code has only one instruction per line.

Not a good point.


Regards.

- --

Angelo Dell'Aera 'buffer' 
Antifork Research, Inc.	  	http://buffer.antifork.org

PGP information in e-mail header


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFALOC+pONIzxnBXKIRApWFAJ9JjvwcnfgPz1V5bvfwzjE2Xb7c5wCfWdOH
s9fGQvTBV3iEaZQdy8tp8nQ=
=v4FT
-----END PGP SIGNATURE-----
