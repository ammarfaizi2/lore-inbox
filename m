Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWFMOxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWFMOxc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 10:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWFMOxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 10:53:32 -0400
Received: from 216-54-166-5.static.twtelecom.net ([216.54.166.5]:53143 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S1751133AbWFMOxb
	(ORCPT <rfc822;linux-kerneL@vger.kernel.org>);
	Tue, 13 Jun 2006 10:53:31 -0400
Message-ID: <448ED167.8080600@compro.net>
Date: Tue, 13 Jun 2006 10:53:27 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: Serge Noiraud <serge.noiraud@bull.net>
Cc: linux-kerneL@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: RT exec for exercising RT kernel capabilities
References: <448876B9.9060906@compro.net> <200606131613.45078.Serge.Noiraud@bull.net> <448ECCE0.8040206@compro.net> <200606131648.22547.Serge.Noiraud@bull.net>
In-Reply-To: <200606131648.22547.Serge.Noiraud@bull.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge Noiraud wrote:
> mardi 13 Juin 2006 16:34, Mark Hounschell wrote/a écrit :
>> Serge Noiraud wrote:
>>> jeudi 8 Juin 2006 21:12, Mark Hounschell wrote/a écrit :
>>>> With the ongoing work being done to rt kernel enhancements by Ingo and friends,
>>>> I would like to offer the use of a user land test (rt-exec). The rt-exec tests
> ...
>>> I ran ./go and after 16:50 hours, the tasks 9 and 10 ( type hrt ) jumped respectively to 9787
>>> and 3843usec ! 5 or 10 minutes earlier I did have between 100 and 200 usec.
>>> What can cause this problem ? is it a hrt problem ?
>>> Could it be a driver problem ( network ) ?
> ...
>> All I can say about those 2 big hits is that your system burped. Why, I can't
>> tell you. The people working on the rt stuff may be able to help you.
>>
>> What bugs me is task16 is not running at all. Tell what kernel and glibc you are
>> using please?
> I forgot to ask you this problem.
> 
> I'm using linux 2.6.16 with rt28.
> glibc-2.3.3
> 
>> Mark

This is a bug in the exec. I'll fix it ASAIC.

Mark
