Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbTEHQj6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 12:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbTEHQj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 12:39:58 -0400
Received: from h-64-105-35-101.SNVACAID.covad.net ([64.105.35.101]:45996 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP id S261827AbTEHQj5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 12:39:57 -0400
Date: Thu, 8 May 2003 09:51:39 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200305081651.h48Gpdd14113@freya.yggdrasil.com>
To: joern@wohnheim.fh-wedel.de
Subject: Re: Binary firmware in the kernel - licensing issues.
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:
>On Thu, 8 May 2003 08:59:52 -0700, Adam J. Richter wrote:
>> Jörn Engel wrote:
>> >For the kernel or the main CPU, the driver firmware is just data. The
>> >same, as the magic 0x12345678ul that gets written to some register
>> >because [can't tell, NDA]. In both cases, magic data gets written
>> >somewhere and afterwards, things just work.
>> 
>> 	I think you are confusing "the preferred form of the work
>> for making modifications to it" (the GPL's definition of "source
>> code") with "documentation."  In the case of poking a few values,
>> the preferred form for making modifications may be actually editing
>> the numbers directly in source code.  That quite likely is the way
>> that all developers maintain and modify that code, even if doing so
>> in an effective manner requires additional documentation.
>> 
>> 	In comparison, with the binary blobs of firmware, the preferred
>> form of the work for making modifications is, presumably, to edit
>> a source file from which the binary blob can be rebuilt using an
>> assembler or compiler.

>What's the difference? If the code uses 0x12345670ul, but 0x12345678ul
>would be correct, who is going to find the correct change without the
>documentation. Maybe someone reverse engineering the meaning of those
>bits. But most just accept the fact that one is better than the other
>without understanding why.

	I agree that documentation would be extremely useful in this
case and that distributing documentation shares a lot of the social
benefits of distributing source code, but the GPL does not require
shipping all forms of documentation, but it does require shipping
source code.  Maybe you think that a future version of the GPL
should require that.  The pros and cons of the discussion would
be interesting, but it is irrelevant to the question of what
version 2 (the version we are discussing) of the GNU General Public
License says.  GPL v2 only requires distribution of "the preferred
form of the work for making modifications to it."  Documentation
of magic numbers is often a separate work, often not even a
machine readable work.

>And one big binary blob is better than the other. Same here.

	"better" is a question for what you think the license
should be, not a question of the meaing of the current license.
The current license does not say "you must do whatever is better."

>Anyway, _should be ok_ is not _definitely legal in all countries_, so
>we basically both say "see a lawyer".

	Although I've never heard a lawyer tell me anything was
"definitely legal in all countries", I agree with your sentiment.
I am not a lawyer.  Please do not rely on this as legal advice.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Miplitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
