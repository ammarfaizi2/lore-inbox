Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314395AbSFISW1>; Sun, 9 Jun 2002 14:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314396AbSFISW0>; Sun, 9 Jun 2002 14:22:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45319 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314395AbSFISW0>;
	Sun, 9 Jun 2002 14:22:26 -0400
Date: Sun, 9 Jun 2002 19:22:24 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.kernel.org
Subject: Re: of ethernet names (was [PATCH] Futex Asynchronous
Message-ID: <20020609182224.GE1078@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Interface)
Reply-To: 
In-Reply-To: <Pine.LNX.4.44.0206091056550.13459-100000@home.transmeta.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime:  19:19:16 up 1 day,  6:46,  5 users,  load average: 2.00, 2.00, 2.00

* Linus Torvalds (torvalds@transmeta.com) wrote:

> On 9 Jun 2002, Kai Henningsen wrote:
> >
> > However, I don't think that's all that important. What I'd rather see is
> > making the network devices into namespace nodes. The situation of eth0 and
> > friends, from a Unix perspective, is utterly unnatural.
> 
> But what would you _do_ with them? What would be the advantage as compared
> to the current situation?

Personally I would do away with ifconfig and replace it with 
cat in and out of device nodes; ifconfig seems to suffer about having to
know about every protocol on every device type and the kernel has to
provide interfaces for it that only it uses.

Dave
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM, SPARC and HP-PA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
