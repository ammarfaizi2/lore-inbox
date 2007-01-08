Return-Path: <linux-kernel-owner+w=401wt.eu-S1161309AbXAHOLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161309AbXAHOLq (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 09:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161310AbXAHOLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 09:11:46 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:45879 "HELO
	embla.aitel.hist.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1161309AbXAHOLq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 09:11:46 -0500
Message-ID: <45A2509F.3000901@aitel.hist.no>
Date: Mon, 08 Jan 2007 15:09:35 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Dirk <d_i_r_k_@gmx.net>
CC: Jay Vaughan <jv@access-music.de>,
       Trent Waddington <trent.waddington@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Gaming Interface
References: <45A22D69.3010905@gmx.net> <3d57814d0701080243n745fcddg8eaace0093e88a38@mail.gmail.com> <45A2356B.5050208@gmx.net> <a06230924c1c7d795429a@[192.168.2.101]> <45A24176.9080107@gmx.net>
In-Reply-To: <45A24176.9080107@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dirk wrote:
> Jay Vaughan wrote:
>   
>> At 13:13 +0100 8/1/07, Dirk wrote:
>>     
>>> Trent Waddington wrote:
>>>  > Call me crazy, but game manufacturers want directx right?  You aint
>>>  > running that in the kernel.
>>> They want something like DirectX that changes it's API less frequent
>>> than DirectX and that compiles as a module because you don't want to run
>>> it in the kernel.
>>>
>>>       
>> Whats wrong with just using SDL/OpenGL?  Thousands of games are made
>> with SDL/OpenGL, and there are realms of Linux usage where this works
>> just fine, especially for games (GP2X, etc).  In case you didn't notice,
>> plenty of pro Game Developers use SDL/OpenGL just fine for their needs,
>> and get the job done without grumbling and groaning about needing to
>> have their hands held through the process.
>>     
>
> But I don't see top titles ported to SDL/OpenGL.
Tough luck then - openGL is the standard gaming interface on linux,
well for the 3D graphichs part at least.  You already have this,
so having a "standard" clearly isn't enough then.

More titles will be ported to linux when linux becomes more
popular as a home platform.  It is that simple.  And then it will
happen no matter what the interface will be.  Although I
believe it will still be opengl - opengl is nice and don't need
to change. Also, the fact that it isn't in the _kernel_ doesn't
matter at all. It is in the standard distributions - that is what matters.


>  You must take into
> account with what kind of people you're dealing with. It's not the pro
> Game Develpers who make decisions. It's the people who completely rely
> on words who ake decisions. So, if you tell them that there will be a
> _official_ API on Kernel level which will be available on all 300+ Linux
> distributions they will understand that they're dealing with something
> they can rely on. 
Wrong.  This kind of people worry about market share and so
they decide on windows games for that reason alone.
> They don't know SDL. And most of these characters
> think OpenGL is dead.
It is wrong - it might be dead _on windows_ because
windows have directx as well as a "less useful" opengl.
>  That's arrogant, I know. They choice about what
> stuff they care is made by big words and statements, not by their
> competence.
>   
Then you won't get support here - nobody cares about
"big words" here.
>> I fail to see the reason this requirement has to be a 'kernel'
>> interface, other than pure sheer laziness and inability to grok on the
>> part of the so-called professional Game Developers.
>>     
>
> That's exactly what I'm talking about. They're lazy and dumb. So they
> need something where they can say: "Hey, that is one interface that
> doesn't change every couple of month. I can try to wrap my lazy brain
> around it with a good feeling."
>   
1. Linux don't support the lazy and dumb. Won't happen.
2. Even the lazy and dumb can use nice standardized unchanging
    interfaces - provided by a library rather than the kernel.  It is not
    harder to do in any way.

>>  Gaming is only
>> *one* kind of application for the Linux kernel - shall we burden the
>> kernel with everything everyone wants just because people fail to
>> understand the proper way to assemble a Linux-based kit for their
>> specific application needs?  (Hint: work with the distro builders.)
>>     
>
> Yes. Exactly. There is already code for very specific tasks in the
> kernel. A module that acts as a
> i-will-never-change-my-api-and-will-be-available-on-EVERY-linux-because
> i'm-part-of-the-kernel wrapper for video, sound and events dedicated to
> the gaming folks wouldn't hurt.
>   
Such a thing is nice - but it don't need to be in the kernel. Try
to understand that! An interface set in stone can be provided
by a standard library that all distros pick up. (No distro will
skip an important library, that way they get behind the other distros.)
The advantage of this is that such a library can keep the
game programmers interface constant even when the kernel interfaces
are mercilessly changed. And yes - they _will_ change.  Everytime
that happens, people here laugh at commercial actors getting
in trouble. (Example - the tradition of ruthlessly breaking the binary-only
modules from ati, nvidia, vmware...)

>> Just my .2c, but anyone suggesting that API's be crowbar'ed into the
>> kernel "just to make it easier to get what you want from a single
>> source" is probably not as familiar with the underlying technology, nor
>> the reasons for its structured organization, as they ought to be before
>> making such suggestions ..
>>     
>
> I'm just guessing that the real problem of Linux gaming is that
> developers must get it that there is an official way to port games to
> linux w/o toolongdidntread, ever changing API's or as many different
> problems as there are distributions.
>   
Sure, and that official way is to use support libraries.  Such
as opengl for 3D, and one of the well-supported sound libraries
for sound, and so on.
> Porting games to Linux has to be _very_ _easy_.
>   
Depends on what you port them from!
People even write free games for linux, so it can't be that hard.
Professional game vendors even get paid, so they shouldn't
have any problem at all then.

> I have this idea to put such standard API into a kernel (module) because
> the kernel, unlike SDL and OpenGL, is available on _every_ Linux
> distribution.
>   
Every _module_ isn't available on every distribution either,
so that's bad thinking. I think you will find the existing
gaming libraries on any distro aiming at "generic" or "home"
usage.  Specialist distros aiming at "servers", "firewalls",
or "small embedded devices" will _not_ have opengl, and not
any kernel interfaces for graphichs either. Putting stuff in the kernel
won't change that.

Note that microsoft does the same thing with its special windows
distributions - I can't run directx games on the display of my
windows CE GPS navigator - even though I can install
third party software there.

> That is the _only_ reason why I think it should be in/part of the
> kernel. As I said before: Simple decision makers will see a difference
> between "Hey, you can port your game using SDL and OpenGL".. or "_Every_
> Linux system/distribution has a standard Interface for all needs that
> won't change for a long time." 
You won't ever get gaming support in every distro - precisely
because some distros aim specifically for unfit machines like
embedded devices. I repeat - opengl is supported in the
distros aiming for home use.

> They will realize that gaming under Linux
> has become _one_ _simple_ problem than a
> number_of_dists*different_configurations=number_of_problems problem.
>
> Give them something they can absolutely rely on (no matter which
> distribution or configuration) and make them realize that Linux is even
> more spread than OS X and they will have $$$ signs in their eyes.
>   
Now you know that it can't happen, and also that the kernel is
the wrong place for game compatibility layers. Still, you can aim
for a standardized game interface present in all home distros.
That is possible.  But you can't get it by posting suggestions here.
All the people who actually code for linux are able to come
up with enough ideas themselves.  So nobody is going to
put your ideas into code - it don't work that way.

Either _you_ code your game interface yourself, or you fund
some developers to do it for you. It is that simple.  You can
of course come here and ask advice about how to do it
and what parts will be accepted into the kernel and what parts
must stay outside it.

This is not the place to post an idea and then expect someone
to actually program it.  This is the place where you may discuss
an idea, and then find out if Linus might accept your patch - or not!

Helge Hafting
