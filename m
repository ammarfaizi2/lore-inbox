Return-Path: <linux-kernel-owner+w=401wt.eu-S1161237AbXAHMAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161237AbXAHMAn (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 07:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161246AbXAHMAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 07:00:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:47880 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161237AbXAHMAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 07:00:42 -0500
X-Authenticated: #9872103
Message-ID: <45A24176.9080107@gmx.net>
Date: Mon, 08 Jan 2007 14:04:54 +0100
From: Dirk <d_i_r_k_@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.2pre) Gecko/20070104 SeaMonkey/1.1
MIME-Version: 1.0
To: Jay Vaughan <jv@access-music.de>
CC: Trent Waddington <trent.waddington@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Gaming Interface
References: <45A22D69.3010905@gmx.net> <3d57814d0701080243n745fcddg8eaace0093e88a38@mail.gmail.com> <45A2356B.5050208@gmx.net> <a06230924c1c7d795429a@[192.168.2.101]>
In-Reply-To: <a06230924c1c7d795429a@[192.168.2.101]>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Vaughan wrote:
> At 13:13 +0100 8/1/07, Dirk wrote:
>> Trent Waddington wrote:
>>  > Call me crazy, but game manufacturers want directx right?  You aint
>>  > running that in the kernel.
>> They want something like DirectX that changes it's API less frequent
>> than DirectX and that compiles as a module because you don't want to run
>> it in the kernel.
>>
> 
> Whats wrong with just using SDL/OpenGL?  Thousands of games are made
> with SDL/OpenGL, and there are realms of Linux usage where this works
> just fine, especially for games (GP2X, etc).  In case you didn't notice,
> plenty of pro Game Developers use SDL/OpenGL just fine for their needs,
> and get the job done without grumbling and groaning about needing to
> have their hands held through the process.

But I don't see top titles ported to SDL/OpenGL. You must take into
account with what kind of people you're dealing with. It's not the pro
Game Develpers who make decisions. It's the people who completely rely
on words who ake decisions. So, if you tell them that there will be a
_official_ API on Kernel level which will be available on all 300+ Linux
distributions they will understand that they're dealing with something
they can rely on. They don't know SDL. And most of these characters
think OpenGL is dead. That's arrogant, I know. They choice about what
stuff they care is made by big words and statements, not by their
competence.

> I fail to see the reason this requirement has to be a 'kernel'
> interface, other than pure sheer laziness and inability to grok on the
> part of the so-called professional Game Developers.

That's exactly what I'm talking about. They're lazy and dumb. So they
need something where they can say: "Hey, that is one interface that
doesn't change every couple of month. I can try to wrap my lazy brain
around it with a good feeling."

>  Gaming is only
> *one* kind of application for the Linux kernel - shall we burden the
> kernel with everything everyone wants just because people fail to
> understand the proper way to assemble a Linux-based kit for their
> specific application needs?  (Hint: work with the distro builders.)

Yes. Exactly. There is already code for very specific tasks in the
kernel. A module that acts as a
i-will-never-change-my-api-and-will-be-available-on-EVERY-linux-because
i'm-part-of-the-kernel wrapper for video, sound and events dedicated to
the gaming folks wouldn't hurt.

> Just my .2c, but anyone suggesting that API's be crowbar'ed into the
> kernel "just to make it easier to get what you want from a single
> source" is probably not as familiar with the underlying technology, nor
> the reasons for its structured organization, as they ought to be before
> making such suggestions ..
> 

I'm just guessing that the real problem of Linux gaming is that
developers must get it that there is an official way to port games to
linux w/o toolongdidntread, ever changing API's or as many different
problems as there are distributions.

Porting games to Linux has to be _very_ _easy_.

I have this idea to put such standard API into a kernel (module) because
the kernel, unlike SDL and OpenGL, is available on _every_ Linux
distribution.

That is the _only_ reason why I think it should be in/part of the
kernel. As I said before: Simple decision makers will see a difference
between "Hey, you can port your game using SDL and OpenGL".. or "_Every_
Linux system/distribution has a standard Interface for all needs that
won't change for a long time." They will realize that gaming under Linux
has become _one_ _simple_ problem than a
number_of_dists*different_configurations=number_of_problems problem.

Give them something they can absolutely rely on (no matter which
distribution or configuration) and make them realize that Linux is even
more spread than OS X and they will have $$$ signs in their eyes.

Dirk
