Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261595AbSJFMfY>; Sun, 6 Oct 2002 08:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263395AbSJFMfY>; Sun, 6 Oct 2002 08:35:24 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:1854 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id <S261595AbSJFMfS>; Sun, 6 Oct 2002 08:35:18 -0400
From: "Joseph D. Wagner" <wagnerjd@prodigy.net>
To: "'Russell King'" <rmk@arm.linux.org.uk>
Cc: "Linux Kernel Development List" <linux-kernel@vger.kernel.org>
Subject: RE: Good Idea (tm): Code Consolidation for Functions and Macros that Access the Process Address Space
Date: Sun, 6 Oct 2002 07:40:44 -0500
Message-ID: <000801c26d35$9d6ac670$81281c43@joe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <20021006105008.B27487@flint.arm.linux.org.uk>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> On Sat, Oct 05, 2002 at 07:58:55PM -0500, Joseph D. Wagner wrote:
>> SUBJECT: Good Idea (tm): Code Consolidation for Functions and Macros
>> that Access the Process Address Space
>>...
>> Remember, if a function call has no place for a returned value to go,
>> nothing bad happens; the returned value is simply ignored/discarded.

> And the compiler warning?

See WHY THIS SHOULD BE CHANGED #3 "Forces better coding structures and
procedures..."  Frankly, error controls should have been programmed into
the code anyway.  It's just good programming practice.

>> SOLUTION:

> Get rid of the _ret forms.  Their use is frowned on today anyway
because
> they hide the real meaning of what the code is trying to do, and
hiding
> the fact that a function can return in the middle of what looks like a
> macro call is _REAL_ _BAD_.

While I respectively disagree with you, I really don't care which set of
functions/macros are eliminated for consolidation purposes.  My original
point still stands that maintaining duplicate functions -- well, near
duplicate with the exception of the returned error code -- is a waste of
time, resources, and coding, and for the purpose of simplified
maintenance, one of the sets of duplicate functions/macros should be
eliminated.

Joseph Wagner

