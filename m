Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284732AbSA2WPd>; Tue, 29 Jan 2002 17:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284300AbSA2WPQ>; Tue, 29 Jan 2002 17:15:16 -0500
Received: from www.transvirtual.com ([206.14.214.140]:4110 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S284732AbSA2WPE>; Tue, 29 Jan 2002 17:15:04 -0500
Date: Tue, 29 Jan 2002 14:14:57 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: MAINTANIANCE [was Re: A modest proposal -- We need a patch penguin]
In-Reply-To: <20020129075245.GA15419@kroah.com>
Message-ID: <Pine.LNX.4.10.10201291049570.29648-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm not proposing replacing the current subsystem maintainers.  But are the 
> current subsystem maintainers happy?

   Usually I don't get involved in these discussions but I like to share
my experiences here and I also like for people see it from the point of
view of Linus.  
   A few years ago I got involved with developement of the framebuffer
layer. Now I work along with Geert on the improvement of this subsystem. 
Do I consider myself a maintainer? Its just a title. All I know is I work
with Geert on this stuff. He has been doing that subsystem alot longer
than I have been and I have the up most high respect for him. So I would
never do anything without his okay. 
   One thing I can tell you is both me and Geert have jobs that don't pay
us to work directly on this (it would be nice HINT!!!!) . We do it out of
our free time. Unfortunely our free time is limited. I know I as well as
Geert receive email from various people on how to write drivers or even
recieve a bunch of patches. I have tried to look at every patch and read
every email. I can tell you it is so hard. Often I don't reply for days or
even weeks at a time. I feel bad sometimes about this but I can't help it.
BTW I don't ever ignore any emails. They might sit there for some time but
eventually I do answer them. Plus I do keep every patch I have been sent.
I even have been sent free hardware to test people's work on. I have
hardware I have been sitting around for several months ago but because I'm
so swamp I just don't get the time to test things on it. Another thing I
have experienced is having my head bite off by driver writers when I
reworked their code or told them this is the way the code should be
written. 
   As for Linus trusting or not trusting me. I hope he doesn't trust me
because I don't even trust myself sometimes. That is why I like to send
out my stuff on mailing list for people to see it. So people can voice
their options and I do see improvements. I'm thankful for trees like DJ
and alan's because I get to see a large audience test it. I have sent in
patches for the dj that worked for me and for a bunch of other people it 
blew up. I see it as a much needed test bed. Only when nearly everyone
that is affected by my work is happy I would consider it worthy to send to
Linus. 
   I can't even imagine being Linus. First we do see him getting flamed
for wanting things a certain way or reworking someone else code. This can
be good if done right. Second he recieves alot of patches every day. I
don't blame him for not looking at a lot of them. In fact I wouldn't doubt
he has a filter for the people he trust to go int one box and the others
go into another box. 
             
   What is the solution for this problem? With my expeirences I have come
up with I found the following to work best. Unfortunely not all have been
applied to fbdev developement but I'm pushing it this way. These are
the goals I'm aiming for.


----------------------- For new device drivers ---------------------------

I.   First we have setup a mailing list for this. He driver writers can
     post their drivers for code review and testing. 

II.  Second step is to place it in a area where people know here to go for
     the latest thing. For fbdev we have setup a CVS where people can ask
     for CVS access and can place their driver their. I like to do it this
     way because it is way to hard for me to track every patch. Plus we
     have had several people write the same driver independent of each
     other.

III. Place it in a beta tree. Announce it to the world.

IV.  The maintainer submits it to Linus. 

----------------------- API changes --------------------------------------

I.   Post a proposal on a mailing list for that subsystem.

II.  Everyone comments. Go to 1 until most people are happy.

III. Next a document maintiner steps forward to write real docs. (We
     haven't done this). I really think every subsystem needs this.

IV.  Start making patches and do above.
   
   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'_   _/`\
 ___)=(___/



