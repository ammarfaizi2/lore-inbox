Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265217AbTLFQrk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 11:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265223AbTLFQrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 11:47:40 -0500
Received: from bay7-dav25.bay7.hotmail.com ([64.4.10.82]:46097 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S265217AbTLFQri
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 11:47:38 -0500
X-Originating-IP: [24.61.138.213]
X-Originating-Email: [jason_kingsland@hotmail.com]
From: "Jason Kingsland" <Jason_Kingsland@hotmail.com>
To: "Theodore Ts'o" <tytso@mit.edu>, "Larry McVoy" <lm@work.bitmover.com>,
       "Linus Torvalds" <torvalds@osdl.org>, "Larry McVoy" <lm@bitmover.com>,
       "Erik Andersen" <andersen@codepoet.org>,
       "Zwane Mwaikambo" <zwane@arm.linux.org.uk>,
       "Paul Adams" <padamsdev@yahoo.com>,
       "Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <20031206153845.GA8552@thunk.org>
Subject: Re: Linux GPL and binary module exception clause?
Date: Sat, 6 Dec 2003 11:47:37 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Message-ID: <BAY7-DAV25C8DWtqchS000047e3@hotmail.com>
X-OriginalArrivalTime: 06 Dec 2003 16:47:37.0661 (UTC) FILETIME=[A7C776D0:01C3BC18]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"Theodore Ts'o" wrote:
> you could potentially have in the single address space:
>
> * Solaris's propietary admin client
> * The libss shared library (BSD)
> * The GPL'ed readline library
>
> OK, riddle me this: is there a GPL violation, and if so, who committed it?

There is no violation so long as the GPL code isn't being distributed as
part of the Solaris proprietary work. It would be the responsibility of the
distributor (Sun?) to ensure the licenses on everything they distribute are
mutually compatible.

That is specifically the reason for the exception clause in GPL:

"
If identifiable sections of that work are not derived from the Program, and
can be reasonably considered independent and separate works in themselves,
then this License, and its terms, do not apply to those sections when you
distribute them as separate works. But when you distribute the same sections
as part of a whole which is a work based on the Program, the distribution of
the whole must be on the terms of this License, whose permissions for other
licensees extend to the entire whole, and thus to each and every part
regardless of who wrote it.
"
