Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264335AbTCXQqw>; Mon, 24 Mar 2003 11:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264333AbTCXQqO>; Mon, 24 Mar 2003 11:46:14 -0500
Received: from mail.ithnet.com ([217.64.64.8]:21263 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S264332AbTCXQox>;
	Mon, 24 Mar 2003 11:44:53 -0500
Date: Mon, 24 Mar 2003 17:55:38 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: jgarzik@pobox.com, rml@tech9.net, mj@ucw.cz, alan@redhat.com, pavel@ucw.cz,
       szepe@pinerecords.com, arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Ptrace hole / Linux 2.2.25
Message-Id: <20030324175538.5c0a4451.skraw@ithnet.com>
In-Reply-To: <85710000.1048520457@[10.10.2.4]>
References: <29100000.1048459104@[10.10.2.4]>
	<3E7E3AF0.6040107@pobox.com>
	<1940000.1048460794@[10.10.2.4]>
	<20030324113035.540cfd25.skraw@ithnet.com>
	<85710000.1048520457@[10.10.2.4]>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Mar 2003 07:40:58 -0800
"Martin J. Bligh" <mbligh@aracnet.com> wrote:

> > [no new trees]
> 
> I see your point, and I'd love to get this stuff merged back to mainline
> 2.4, and that would actually be the whole point of doing this ... to
> provide a channel of stuff that should get merged back. The other thing to
> bear in mind is that what I want is not really another to turn 4 branches
> into 5, it's to turn 4 branches into two branches with a couple of twigs
> off each ;-) So I actually want *more* commonality.

I do know your brave intentions, only you are heading in the wrong direction.
Simple thing is: the more you split off new trees the fewer testing they will
get. This is simply because only very (read VERY) few people run different
trees (kernels) every day on their boxes. They decide for _one_ tree and try to
stay there. Simply because most people want to do something useful besides the
testing. So they cannot go and reboot their machines 20 times a day only to
know which patch of what tree looks like being "the right thing(tm)" for them.
Forget that.
So the more trees you spin off the fewer testing your mainline will get, _and_
the lower the pressure will be to make the needed patches work in the mainline.
The people needing good working SMP/VM/name-one will go and use -aa -rmap
-name-one instead, because they believe they have no other chance _right now_.
And they won't come back that easy.
The only thing that can be done against this phenomenon is to speed up mainline
patch release and make it _reliable_. This is why I made the suggestion
(elsewhere) to release a -pre every week on the same weekday. People will know
when the next one comes in. They have a plan, it is reliable.
Another very good reason is: the steps between the -pres are smaller, so there
is less risk for a complete failure or a mis-direction of certain development
steps.
And again this is a good argument for Marcelo needing more time for
maintenance, more releases = more time.

> > Another thing has already been talked about here, so lets talk real open
> > about it: some of us are living in the strong impression that Marcelo has
> > problems with the pure time working on maintaining. I do not know
> > anything about the backgrounds, but if this is really true, then let _me_
> > ask Conectiva if there is a chance that he can do the maintaining
> > full-time. I mean this is for sure one of the interesting PR activities,
> > too. After all those years it is still true: there can be only one.
> > Of course this only makes sense if he still really wants to do that. _Me_
> > asking this because I am in no way related to any other distro, vendor or
> > Marcelo, just being the "linux-enthusiast from next-door" (with management
> > background ;-). 
> 
> If Marcelo would like some more help from others for integration / testing
> whatever, I'm sure it could be arranged if he described what he'd like. I
> know that helps me out a lot at least if I can get others to help me ...
> (eg. take these 5 patches, merge them on top of my latest prerelease, and
> kick the snot of them for me to see if they're basically looking OK). 
> 
> There's plenty of talent and enthusiasm around on LKML that's able to share
> the burden ... would be much more constructive than us (myself included)
> complaining ;-)
> 
> M.

This is no real solution. There are already maintainers for big and small parts
of the kernel. The simple truth is: there are quite a lot of parts, and there
is no way around the fact that one person (the lines maintainer) has to keep
it all together somehow - and you need time to do that. This _is_ a really
important job.

Sh*t, I do not really want to initiate major discussion about this whole issue,
as I do believe that most of the story is clear to most of the people, and
after all it is a tech mailing list. We could talk for years with no productive
outcome ever.

--- 
Regards,
Stephan
