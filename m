Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWFMOeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWFMOeR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 10:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWFMOeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 10:34:16 -0400
Received: from 216-54-166-5.static.twtelecom.net ([216.54.166.5]:42983 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S1751165AbWFMOeQ
	(ORCPT <rfc822;linux-kerneL@vger.kernel.org>);
	Tue, 13 Jun 2006 10:34:16 -0400
Message-ID: <448ECCE0.8040206@compro.net>
Date: Tue, 13 Jun 2006 10:34:08 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: Serge Noiraud <serge.noiraud@bull.net>
Cc: linux-kerneL@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: RT exec for exercising RT kernel capabilities
References: <448876B9.9060906@compro.net> <200606131613.45078.Serge.Noiraud@bull.net>
In-Reply-To: <200606131613.45078.Serge.Noiraud@bull.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge Noiraud wrote:
> jeudi 8 Juin 2006 21:12, Mark Hounschell wrote/a écrit :
>> With the ongoing work being done to rt kernel enhancements by Ingo and friends,
>> I would like to offer the use of a user land test (rt-exec). The rt-exec tests
>> well the deterministic real-time capabilities of a computer. Maybe it could
>> useful in some way to the effort or to anyone interested in making this type of
>> determination about their kernel/computer.
>>
>> A README describing the rt-exec can be found at
>> ftp://ftp.compro.net/public/rt-exec/README
>>
>> It can be downloaded from
>> ftp://ftp.compro.net/public/rt-exec/rt-exec-1.0.0.tar.bz2
>>
>> Complaints, comments, or suggestions welcome.
> Great tool.
> 
> I ran ./go and after 16:50 hours, the tasks 9 and 10 ( type hrt ) jumped respectively to 9787
> and 3843usec ! 5 or 10 minutes earlier I did have between 100 and 200 usec.
> What can cause this problem ? is it a hrt problem ?
> Could it be a driver problem ( network ) ?
> 
> I send the png in copy.
> 
> 
> 
> ------------------------------------------------------------------------
> 

All I can say about those 2 big hits is that your system burped. Why, I can't
tell you. The people working on the rt stuff may be able to help you.

What bugs me is task16 is not running at all. Tell what kernel and glibc you are
using please?

Mark
