Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbWCFOR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbWCFOR3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 09:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWCFOR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 09:17:29 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:12208 "EHLO XSMTP0.ethz.ch")
	by vger.kernel.org with ESMTP id S1750872AbWCFOR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 09:17:29 -0500
Message-ID: <440C4472.8000509@debian.org>
Date: Mon, 06 Mar 2006 15:17:22 +0100
From: "Giacomo A. Catenazzi" <cate@debian.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: "Paul D. Smith" <psmith@gnu.org>, bug-make@gnu.org,
       LKML <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net,
       Art Haas <ahaas@airmail.net>
Subject: Re: [kbuild-devel] Re: kbuild: Problem with latest GNU make rc
References: <17413.49617.923704.35763@lemming.engeast.baynetworks.com> <20060304214026.GB1539@mars.ravnborg.org> <17419.25684.389269.70457@lemming.engeast.baynetworks.com> <20060305231954.GA25710@mars.ravnborg.org>
In-Reply-To: <20060305231954.GA25710@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Mar 2006 14:17:22.0704 (UTC) FILETIME=[AF96F100:01C64128]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
>>   sr> Suggestion:
>>   sr> We are now warned about an incompatibility in kbuild and we will
>>   sr> fix this asap. But that you postpone this particular behaviour
>>   sr> change until next make release. Maybe you add in this change as
>>   sr> the first thing after the stable relase so all bleeding edge make
>>   sr> users see it and can report issues.
>>
>> I am willing to postpone this change.  However, I can't say how much of
>> a window this delay will give you: I can say that it's extremely
>> unlikely that it will be another 3 years before GNU make 3.82 comes out.
> 
> One year would be good. The fixed kernel build will be available in an
> official kernel in maybe two or three months form now. With current pace
> we will have maybe 3 more kernel relase until this hits us. And only on
> bleeding edge machines.

I don't think is a big issue. The short-cut "compile only the necessary
files" is used mainly by developers.
Anyway the kernel will remain correct. Maybe for old kernel it take more
time to build the kernel, but correct.

BTW Debian building tools (IIRC) clean the sources before every kernel
building process, and in 2.4 (and previous) it was high recommended to
clean and recompile all kernel before any changes, so no big issue in
these cases.
I don't know other "normal use", but I think it is not a big issue if
people will need a complete build in the rare (IMHO) case that they
want to recompile kernel (with small patches or changes in configuration).

ciao
	cate

