Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284495AbRLHT4D>; Sat, 8 Dec 2001 14:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284477AbRLHTz6>; Sat, 8 Dec 2001 14:55:58 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:54740 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S284495AbRLHTzn>; Sat, 8 Dec 2001 14:55:43 -0500
Date: Sat, 8 Dec 2001 20:55:41 +0100
From: bert hubert <ahu@ds9a.nl>
To: jamal <hadi@cyberus.ca>
Cc: lartc@mailman.ds9a.nl, linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru,
        netdev@oss.sgi.com
Subject: further CBQ/tc documentation ds9a.nl/lartc/manpages
Message-ID: <20011208205541.A15565@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, jamal <hadi@cyberus.ca>,
	lartc@mailman.ds9a.nl, linux-kernel@vger.kernel.org,
	kuznet@ms2.inr.ac.ru, netdev@oss.sgi.com
In-Reply-To: <20011203030002.A20601@outpost.ds9a.nl> <Pine.GSO.4.30.0112030831520.20924-100000@shell.cyberus.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.30.0112030831520.20924-100000@shell.cyberus.ca>; from hadi@cyberus.ca on Sat, Dec 08, 2001 at 02:20:20PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2001 at 02:20:20PM -0500, jamal wrote:

> > The parts of the table of contents that document stuff in the kernel not
> > documented elsewhere:
> 
> "not documented elsewhere" comes out rude. Werner and I (and even
> Alexey when he was in the mood -- and i have seen some good documentation
> by other people as well) have spent numerous hours documenting, presenting
> and answering questions on mailing lists at times

True. I should have worded that better but I lost sight of politeness due to
my great enthusiasm at finally understanding everything. Some parts required
literally *hours* of digging through sources and disembodied slides -
presentations lose something without a speaker.

> Sample docs that i was personally involved in:
> ftp://icaftp.epfl.ch/pub/linux/diffserv/misc/dsid-01.txt.gz

These days I understand this document, but I didn't used to. That might be
because I'm thick, though.

> You need to introduce the big picture to the user.
> and what is wrong with the definitions used in
> http://www.davin.ottawa.on.ca/ols/img10.htm that forced you to introduce
> your own?

I've since moved to this terminology. Please also see the manpages I'm
writing at 
                        http://ds9a.nl/lartc/manpages


> Actually, the big picture is:
> http://www.davin.ottawa.on.ca/ols/img9.htm
> Also
> http://www.linuxjournal.com/article.php?sid=3369
> (was written in 98 but got published in 99)

Google is surely to be praised - I had found all these links already. But to
summarize: stuff is out there.

> [My complaints about your style is you often are trying to present facts
> by using opinions. For example despite a lot of effort in the past to
> explain ingress qdisc to you in the past and, pointing you to very good
> documentation from CISCO you still ended using your opinions on what you
> thought it should be;->

I really didn't understand how everything worked back then, sadly. I do now,
hopefully.

> My scanning of the document shows opinions still posing as miscontrued
> facts. It is improving compared to what i saw last when we discussed ingress.
> Let me clarify one thing in this email; i'll read what you have later.

Some stuff remains from that time, am working on removing it. My current
efforts is writing the manpages and getting them 100% right and devoid of
opinion.

Once they are finished & reviewed, I'm 'backporting' the insight to the
HOWTO, which will then lose a lot of content and instead refer to the
manpages.

> Lets start by your description of TC_PRIO and TOS mappings etc:
> Your descriptions of these values is insufficient. Consider this a
> tutorial and reword it as you wish but please avoid opinions.

Will do, it makes sense now.

> Look at RFC 1349 for typical values used by different applications
> Then of course note that RFC 1349 is obsoleted by RFC 2474 (yes, you can
> weep);

That confused me greatly, yes.

> What i think would be useful for you to do is describe some of the vlaues
> used by some applications (RFC 1349 cut-n-paste job would help).

Thanks. I'm working on making the HOWTO more factual and the manpages 100%
factual. I'm always happy with critiques.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
Trilab                                 The Technology People
Netherlabs BV / Rent-a-Nerd.nl           - Nerd Available -
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
