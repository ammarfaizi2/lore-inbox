Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314138AbSE1MHY>; Tue, 28 May 2002 08:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314243AbSE1MHX>; Tue, 28 May 2002 08:07:23 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:61196 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S314138AbSE1MHW>;
	Tue, 28 May 2002 08:07:22 -0400
Date: Tue, 28 May 2002 06:04:06 -0600
From: yodaiken@fsmlabs.com
To: linux-kernel@vger.kernel.org
Subject: A reply on the RTLinux discussion.
Message-ID: <20020528060406.A18344@hq.fsmlabs.com>
In-Reply-To: <57.c083d0f.2a237c49@aol.com> <20020527123643.9297A11973@denx.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tape loops and arguments
Disclaimer: I am not a lawyer and this contains no legal advice. 

Many years ago during one of the earlier episodes of this, now regular,
attack, I asked one of the first RTLinux contributors why he did not
speak up to defend us and he said something like: I agree with all of your
complaints, but I don't need the abuse I'd get for speaking up. 

It's standard practice on the Internet that the loudest, most persistent, 
and most intransigent can "win" arguments by making it simply too unpleasant
for everyone else. 

I don't participate in these disputes anymore, since they don't seem to get
anywhere. I do want to address some claims that are widely made here.


1. MYTH: "The acceptance of Linux in embedded is being harmed by uncertainty over
    intellectual property"
    
	This is not correct from what I can see. Our customers include 
	several Fortune 500 companies, and an incredible range of smaller
	companies around the world. The use of the free GPL RTLinux is hard
	to quantify, but we from all indications it is enormous. There are
	multiple mirrors, and we still had to limit download bandwidth on our
	site to 1G/day.

	Our resellers and OEM partners include some of the most serious
	players in the embedded Linux business:  LynuxWorks, RedSonic, and
	Red Hat. 

	And most of embedded Linux use does not require hard real-time.

	This issue is perhaps based on problems seen by
	the people who are yelling so loud - although I do not doubt that
	all the yelling does put off some potential adopters. 
	There are also some issues particular to RTAI technology and 
	support that we believe will put off adopters: an API in flux,
	no solid commercial support, stability issues and so on.

	RTLinux is doing very well and there is no uncertainty about
	it. If other variants are not doing well, there are other reasons.


2. MYTH "The patent license is a terrible burden and terribly vague".  
	The real dispute here has very little to do with the 
	patent itself, and a great deal to do with GPL "linking". 
	Linux itself permits binary modules and is generally pretty 
	relaxed about what you can do to the kernel. But for companies
	like FSMLabs, Namesys, Trolltech, MySQL, and for many other
	GPL developers - controlling the right to add non-GPL components
	to our code is a business fundamental. Behind all the rhetoric
	of "I'm only in this for the greater glory of free-software" from
	our die-hard opponents, you find the demand to be allowed to make
	derivative works that incorporate non-GPL code - without payment of
	any fee. 

	Robert Schwebel has made the issue quite clear on occasion, by 
	arguing that in the embedded controller world, the valuable IP
	often is _required_ to be tightly integrated into the base real-time
	system. I think he is partly right, but this is precisely the
	advantage we have as owners of the core RTLinux copyright.
	
	The patent license is absolutely clear: GPL software can
	use the patented method without payment of any fee. So 
	any dispute is on when one can use non-GPL software as a
	component - and in many respects the 
	the real-question is whether the Linux binary module exception 
	can be imposed on everyone else. 
	In the dispute with our
	RTAI friends, most admit that RTAI derives from the RTLinux
	code base. Given this, the absence of a patent would not
	solve the problem that Schwebel sees: it would still not be
	permitted to link binary modules into the derived program without
	our permission.  RTAI "user space"  to me, does not escape this
	issue. 
	
	All that said: we're not against making allowances for small support
	companies: ask.
	
3. Although most RTAI developers agree that RTAI started from the RTLinux
   code base, this issue keeps being obscured.  In the Linux tradition:
  the code is definitive. If you look at 
    ftp://ftp.llp.fu-berlin.de/LINUX-LAB/RTAPPS/paolo/
  you can see most of the history of RTAI, from "myrtlinux 0.6" which 
  is openly billed as a variant of RTLinux 0.4  - note the peculiar copyright
  statement. 

There is certainly a lot 
more there than modified RTLinux, but whatever the virtues or lack 
thereof of this extra material, the absence of any of the RTLinux developer
copyright notices in RTAI is noteworthy.


4. The point of the argument. 
It is is obviously not worth arguing with people like David Schleef
who can baldly assert that RTAI predated RTLinux and did not fork from it.

Karim Yahgmour writes that he has
asked the same questions over and over and not received a response.
The tactic of asking questions that are really insinuations is 
to me an indication of the ethics of the questioner.
"Questions" of the
form "did you steal XYZ code?" asked in the absence of any evidence are
not  questions, they are a dishonest way of damaging a reputation.

Q:Why is there no copyrighted material in RTLinux from Paolo Mantegazza?
A: Because none of his code was incorporated.
Q: Did we take Wolfgang Denk's MPC860 patches?
A: No. Why would we? Cort and I shipped working code for MPC860/Linux
   as our first consulting project, long before FSMLabs existed.
Q: Are other people allowed to contribute code to RTLinux?
A: Learn how to use FTP.  The answer is yes. 
Q: Various questions implying shabby treatment of Michael Barabanov.
A: Karym has been "asking" such "questions" for years. In all that time
   he has refused to take my suggestion that he ask Michael whether Michael
   appreciates this effort.
   
and so on. It's both annoying and tedious.

As for the requests for legal advice: Yahgmour has been playing Internet
lawyer and encouraging people to sue us for a long time. The presence he
makes to simply be asking for information is as believable as the rest of his
pitch.


