Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbTJ2Nnw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 08:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbTJ2Nnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 08:43:52 -0500
Received: from pushme.nist.gov ([129.6.16.92]:59370 "EHLO postmark.nist.gov")
	by vger.kernel.org with ESMTP id S262068AbTJ2Nnv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 08:43:51 -0500
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>
Subject: Re: APM suspend still broken in -test9
References: <3F9D62DD.9020503@pacbell.net>
	<9cffzhezd9i.fsf@rogue.ncsl.nist.gov>
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: Wed, 29 Oct 2003 08:43:37 -0500
In-Reply-To: <9cffzhezd9i.fsf@rogue.ncsl.nist.gov> (Ian Soboroff's message
 of "Mon, 27 Oct 2003 14:33:45 -0500")
Message-ID: <9cf7k2o2m7q.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Scratch that.  I attempted to wake up the laptop yesterday after it
had been sleeping for several hours, and it was locked hard.  My
success report was based on just a quick sleep of a minute or so.

The last -test kernel that works properly for APM suspend and resume
for me is -test7.

Ian

Ian Soboroff <ian.soboroff@nist.gov> writes:

> Yes, that patch solves it for me, and applies cleanly to -test9.
> Ian
>
> David Brownell <david-b@pacbell.net> writes:
>
>> Those are the same symptoms I saw in test7, fixed by:
>>
>>    http://marc.theaimsgroup.com/?l=linux-kernel&m=106606272103414&w=2
>>
>> Patrick, were you going to submit your patch to resolve this?
>> I'm thinking this kind of problem would meet Linus's test10
>> integration criteria.
>>
>> (That's not an APM problem, it's a generic PM problem that'd
>> show up with swsusp too.  And likely even some ACPI systems.)
>>
>> - Dave

