Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbVI2Od2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbVI2Od2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 10:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbVI2Od2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 10:33:28 -0400
Received: from magic.adaptec.com ([216.52.22.17]:35213 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932167AbVI2Od0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 10:33:26 -0400
Message-ID: <433BFB1F.2020808@adaptec.com>
Date: Thu, 29 Sep 2005 10:33:03 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
CC: Andre Hedrick <andre@linux-ide.org>,
       Patrick Mansfield <patmans@us.ibm.com>,
       Luben Tuikov <ltuikov@yahoo.com>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <Pine.LNX.4.10.10509281227570.19896-100000@master.linux-ide.org> <433B0374.4090100@adaptec.com> <20050928223542.GA12559@alpha.home.local>
In-Reply-To: <20050928223542.GA12559@alpha.home.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Sep 2005 14:33:13.0036 (UTC) FILETIME=[B8C398C0:01C5C502]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/28/05 18:35, Willy Tarreau wrote:
> There are people buying expensive hardware. The type of hardware
> that costs $100k for just a few CPUs. Those people don't buy "the
> Adaptec XXX which runs best with Red Hat Enterprise" nor the "LSI
> YYY which runs best with Solaris", they buy a few $100k systems
> with 3 TB disk to store their monthly logs. They cannot even imagine
> that the hardware in the $100k system will not be fully supported by
> some recent OS, that's just plain silly. The OS cost is just a water
> drop in the middle of this. When they install Solaris on it because
> they're used to run it, it just works. When I sometimes just show
> them that Solaris is not adequate for daily greps in logs, and I show
> them how faster it is on a $1k Linux machine in the next rack, they
> feel they can switch to it easily. But if they discover that this
> system does not correctly support their $100k hardware, do you know
> which one was is the crap ? the $300 Red Hat or the $100k hardware ?
> [ oh, BTW, I forgot to tell you : they say "Red Hat", and not "Linux"
> because it does not sound like what they long considered an OS for
> tamagotchis - to use their own words - :-( ]

Yes, all true.

Sadly, most developers here do not _use_ Linux, or are at least
shielded from using Linux, in a _business_.

All the while, Linux _development_, seems to follow some kind
"yours/mine", "gimme that/take that" kindergarten kind of way.
The reason I'm saying this is that _every_ successful entity
(person, corporation, etc) knows that in order to _survive_
it needs to _quickly adapt to new things_: new technologies,
new trends, new fads, etc.

But eventually, when entities get too successful, they
get _complacent_ (with themselves) and turning _away_
from their younger style of functioning (of absolving
everything in order to get successful in the first place).

All this, of course, it the _natural_ way of history.  We
see it when studying History, and we see it every day
when reading the Technology section of our favourite
publication.

Some companies are _fiercly_ trying to beat this _natural_
course of History, into turning 180 degrees from their mindset
every single year in order to chase the latest technology, the
latest fad, in order to please customers and stay on top.

I wish Linux would return to its roots.

> And when they go to adaptec site to find latest drivers and they only
> find patches which forces them to find another Linux to install the
> sources and guess how to patch and build, do you know which OS they
> consider as hobbyist's ? The Red Hat ! (which they can call "Linux"
> again then).

OMG, "hobbyist" -- this so perfectly describes it!  LOL

So now, if there is any coroprate management from RH here reading
this they'd take heed in this.

Linux _development_ needs to catch up to Linux _deployment_.

Currently they are two different worlds.

> Hans Reiser once said that every software needs a complete rewrite
> every 3 or 5 years (I don't precisely remember). I tend to agree
> with him. Maybe it's time to completely rewrite the SCSI subsystem,
> but maybe it will be too long, too risky and not worth the effort.
> Maybe it can simply coexist with another new subsystem. This is what

Now _this_ is a smart suggestion: it wouldn't break legacy hardware
_and_ it would give Linux SCSI a fresh start.

Next year, your new serverboard wouldn't have any of those old
cumbersome storage chips to worry about.  It would have only one
storage chip which could do SAS and SATA and that'd be that.
Why would anyone need this fat, old semanticaly overloaded,
SPI-centric SCSI Core?

> Luben, you seem to have enough knowledge to draw both diagrams
> side-by-side :
>  - the T10 spec with colors on the boxes covered by your work
>  - the Linux view of SCSI
> 
> Perhaps we will see that current code can be extended without too
> much work, or perhaps we will see that it's definitely a dead end
> and that a new design will help a lot.

Yes, I'll get that jpg and try to color it, but there's
also a lot of other components (Interconnect, SDS,
Application Client) which are not visible in this interconnect.

I'll try to get something descriptive.

> Anyway Luben, I fear that for some time, you'll have to provide
> pre-patched sources as well as binary kernels to enterprise customers
> who still try to get Linux working in production. I hope that this sad
> experience will not discourage other vendors from trying to take the
> opensource wagon, as it clearly brings fuel to closed-source drivers
> at the moment (no need to argue).

Foremost, this experience reminds other vendors that Linux
_development_ model is _not_ en par with their Linux _deployment_
model (i.e. for a business).

Many things are left to the whim of developers whose educational
and technical background could be in question especially when
your only communication with them is via email.

I mean -- I don't even know the _age_ ballpark of most developers
here.  (Other than ones I've seen at OLS.)  For all I know I could
be having a discussion with a 9 year old kid, repeating SAM and SPC
references over and over again.

I just don't see the technologically savvy and _open_ community
here.

> Eventhough I don't have SAS, I sincerely hope that a quick and smart
> solution will be found which keeps everyone's pride intact, as it

I'm not shoving my solution down the throats of LSI or James or
Christoph.  Why?
 - because the technologies are different,
 - beacause I'm following a SAM model, they are not.
 - and because I'm not changing anybody else's code but integrating
   with it.

(Jeff, I know that on the 3rd point, you'd say "That's the problem,
you should be improving SCSI Core", and I know that if I had been
changing other people's code, you'd say "You should not change
other people's code", so it's a win-win-manipulative situation
for you.  I'm aware of that, spare your keystrokes.)

This is all _fine_ with me as long as they are not shoving down
my throat their solution.

I wonder the pride to technological merit ratio in Linux SCSI.

> seems to matter much those days. In an ideal situation, 2.7 would
> have been opened for a long time,

Maybe things are slowing down for Linux?  Attitude?  Complacency?
History?  Who knows?

> and Luben's code would have been
> discussed to death as a new development needed to be merged before

We did have a Storage BOF (Birds Of Feather) at the Ottawa Linux
Symposium (OLS) in July this year.  It was called "SAS" and someone
made me do the presentation.  Drawing on a white board several layers
and how they communicate with each other, how things work, why they
work the way they work, how they are shown and represented and why.

The response I got from James and Chritsoph was:
"The sysfs tree would be too deep."

The next day I learned that such argument is bogus and a sysfs
tree can be as deep as the representation calls for.

So you see, _this_ is where we started -- with _this_ kind
of argument: "The sysfs tree would be too deep."

BTW, James already had already had my code for about two
weeks before OLS.

	Luben
