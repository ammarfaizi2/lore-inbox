Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261531AbSJQPbC>; Thu, 17 Oct 2002 11:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261532AbSJQPbC>; Thu, 17 Oct 2002 11:31:02 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:63366 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261531AbSJQPbA>; Thu, 17 Oct 2002 11:31:00 -0400
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Gruenbacher <agruen@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Posix capabilities
References: <20021016154459.GA982@TK150122.tuwien.teleweb.at>
	<20021017032619.GA11954@think.thunk.org>
	<874rblcpw5.fsf@goat.bogus.local> <200210171302.25413.agruen@suse.de>
	<20021017121213.GA13573@think.thunk.org>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Thu, 17 Oct 2002 17:36:40 +0200
In-Reply-To: <20021017121213.GA13573@think.thunk.org> ("Theodore Ts'o"'s
 message of "Thu, 17 Oct 2002 08:12:13 -0400")
Message-ID: <87y98x84c7.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> writes:
> On Thu, Oct 17, 2002 at 01:02:25PM +0200, Andreas Gruenbacher wrote:
>> With capabilities the kernel ensures that
>> applications cannot exceed their capabilities.

Which is a _big_ plus.

> as compared
> to having every single individual administrator have make this
> determination by his or herself.

I don't see this. It's a distribution issue. There will be
administrators, who want to do it on their own, but those will be a
minority.

> Each additional thing which the system administrator has to do, is an
> additional thing that he/she can *get* *wrong*.  System administators
> aren't stupid, just over-loaded, and often asked to administer
> something that's too complicated.

Once the distributions have taken care of this, there's nothing too
complicated left.

> Millions and millions of knobs and dials are not necessarily a good
> thing.  If there is basically only one correct answer for how the
> knobs can be set up, sure, you can have a complex database for
> applications to determine what sort of capability masks they should
> have, and you can run that database against your database every night
> (otherwise, you might miss someone quietly modifying one or two
> capability masks to leave him/herself a back door).  
>
> But why go through all that effort?

Because it's easier, than patching millions and millions of programs?

Regards, Olaf.
