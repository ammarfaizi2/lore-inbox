Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264421AbTDXEfl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 00:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264429AbTDXEfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 00:35:41 -0400
Received: from franka.aracnet.com ([216.99.193.44]:28036 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264421AbTDXEf2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 00:35:28 -0400
Date: Wed, 23 Apr 2003 21:47:25 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Werner Almesberger <wa@almesberger.net>
cc: Jamie Lokier <jamie@shareable.org>, Matthias Schniedermeyer <ms@citd.de>,
       Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>, pat@suwalski.net
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <29360000.1051159644@[10.10.2.4]>
In-Reply-To: <20030424003742.J3557@almesberger.net>
References: <1508310000.1051116963@flay>
 <20030423183413.C1425@almesberger.net> <1560860000.1051133781@flay>
 <20030423191427.D3557@almesberger.net> <1570840000.1051136330@flay>
 <20030424001134.GD26806@mail.jlokier.co.uk>
 <20030423214332.H3557@almesberger.net>
 <20030424011137.GA27195@mail.jlokier.co.uk>
 <20030423231149.I3557@almesberger.net> <25450000.1051152052@[10.10.2.4]>
 <20030424003742.J3557@almesberger.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> You turn it off once, and your distro keeps it that way. Doesn't seem
>> that onerous to me. 
> 
> Okay, so now your distribution is aware of this configuration
> issue.

Can be. But does something sensible without it.
 
>> Indeed. Initial impression of people upgrading a kernel from 2.4 to 2.5/6
>> is that "sound doesn't work in 2.5/6". Not good.
> 
> ... but now it isn't. What gives ?

Not sure what you mean. Load kernel, load xmms. hit play. Sound comes out.
Goodness.
 
> (Besides, you've just added the "silent" flag as another config item
> besides the volume setting, using different interfaces, different
> permissions, etc.)

Yeah. But the default options now do something non-confusing.
 
>> And all for the fact that when the user sets up the system, it just
>> works. With sensible defaults. Instead of being an elitist piece of
>> crap that only l33t g33ks can use.
> 
> Fine. But this discussion isn't about the end-user experience,
> but about where a certain parameter should be set, and what its
> transient default value should be.

Umm. This discussion is exactly about the end-user experience.
And it's not a transient default ... it's the initial default.

> Unexperienced users will just install a set of packages to upgrade
> to a new kernel. So this change can just be included in one of
> these upgrades. No superhuman effort needed.

So we can fix it in userspace, and decided a sensible non-zero default
there, but are somehow incapable of doing that *inside* the kernel? Sorry,
I don't buy that. 

There is a middle ground between "clueless newbie" and "geek who spends
their whole life configuring Linux, and is happy to change 2000 settings on
every install" ... something like "person who just wants to get on with it,
and not fiddle endlessly with things that should just work".
 
> As far as those are concerned who painstakingly build their own
> kernel, update the things listed in Documentation/Changes, avoid
> suble traps like CONFIG_SERIO_I8042, don't get confused by needing
> new module utilities, etc., I'm fairly confident that they'll
> consider setting the volume a rather minor challenge.
> 
> And you could even take the sting out of this one by adding an
> appropriate warning to Documentation/Changes. That's a about all
> the kernel-side support this issue deserves.

The old "document the bugs" arguement. I've been there before - Dynix/PTX.
We ended up with 1000 pages of utter crap for users to wade through as
"release notes". I got into the habit of taking a printed out copy to
meetings and whenever anyone uttered the phrase "but it's documented in the
release notes" I could thump the monster down on the table and say "find
it". They never could by the end of the meeting.

Bugs should be fixed, not documented.

M.

