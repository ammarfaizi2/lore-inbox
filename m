Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263352AbTJQIVi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 04:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263354AbTJQIVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 04:21:38 -0400
Received: from forty.greenhydrant.com ([208.48.139.185]:56710 "EHLO
	forty.greenhydrant.com") by vger.kernel.org with ESMTP
	id S263352AbTJQIVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 04:21:37 -0400
Message-ID: <1168.66.75.241.88.1066378919.squirrel@www.greenhydrant.com>
In-Reply-To: <1066365074.15931.195.camel@cube>
References: <1066356438.15931.125.camel@cube>
    <20031017032436.GA17480@mcgroarty.net>
    <1066365074.15931.195.camel@cube>
Date: Fri, 17 Oct 2003 01:21:59 -0700 (PDT)
Subject: Re: /proc reliability & performance
From: "David Rees" <drees@greenhydrant.com>
To: "Albert Cahalan" <albert@users.sf.net>
Cc: "Brian McGroarty" <brian@mcgroarty.net>,
       "linux-kernel mailing list" <linux-kernel@vger.kernel.org>,
       lm@bitmover.com
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, October 16, 2003 at 9:31 pm, Albert Cahalan sent the following
> On Thu, 2003-10-16 at 23:24, Brian McGroarty wrote:
>> On Thu, Oct 16, 2003 at 10:07:18PM -0400, Albert Cahalan wrote:
>> > I created a process with 360 thousand threads,
>> > went into the /proc/*/task directory, and did
>> > a simple /bin/ls. It took over 9 minutes on a
>> > nice fast Opteron. (it's the same at top-level
>> > with processes, but I wasn't about to mess up
>> > my system that much)
>>
>> Are there many cases where the /proc directory
>> contents are read in this fashion?
>
> Sure. Run any of: top, ps, lsof, fuser...

I can vouch that with as few as a 3-5 hundred threads/processes started up
and not necessarily doing much, top starts using a good deal system time
on a somewhat aging dual PIII server on recent 2.4.x kernels.

-Dave
