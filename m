Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262812AbTIEPgy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 11:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262849AbTIEPgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 11:36:53 -0400
Received: from smtp03.web.de ([217.72.192.158]:19472 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S262812AbTIEPgf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 11:36:35 -0400
From: "Mehmet Ceyran" <mceyran@web.de>
To: <linux-kernel@vger.kernel.org>
Subject: RE: nasm over gas?
Date: Fri, 5 Sep 2003 17:39:20 +0200
Message-ID: <003901c373c3$e02f5080$0100a8c0@server1>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <200309051357.h85DvkLX000207@81-2-122-30.bradfords.org.uk>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Error-checkers like Lint, that use a specific langage such 
>> as 'C', can provide the programmer with a false sense of
>> security. You  end up with 'perfect' code with all the
>> unwanted return-values cast to "void", but the logic remains
>> wrong and will fail once the high-bit in an integer is set.
>> So, in some sense, writing procedures in assembly is
>> "safer". You know what the code will do before you run it.
>> If you don't, stay away from assembly.
> This is part of what makes someone a 'real' programmer, in my opinion.
> In my experience, 'Unreal' programmers tend to excessively 
> re-use code from other applications they've written, and just 
> hack it about until it works, at times leaving in code for 
> features that are never used in the new context :-).

Code re-usage is not a bad thing in computer science because it can save
you much work. But it has to be done correctly. Best thing is to use
so-called "design patterns": Solutions to common problems that have been
proven to work in many different environments. So if you solved some
problem in your past programs (of course specifying it well before) and
you prove that it doesn't work only for that particular program, then
there's no need to reinvent the wheel. For example that's why you use
standard libraries for basic operations like output to console.

You're right in the part that one should not have to hack the re-used
code until it works because that leads to dirty coding.

I'd also like to mention that algorithms implemented in high-level
languages can be mathematically proven too, for example with the hoare
calculus, which provides basic axioms for handling of sequences, loops
and conditional statements.

	Mehmet

