Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263443AbRFFS2o>; Wed, 6 Jun 2001 14:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263982AbRFFS2f>; Wed, 6 Jun 2001 14:28:35 -0400
Received: from [213.96.124.18] ([213.96.124.18]:37098 "HELO dardhal")
	by vger.kernel.org with SMTP id <S263443AbRFFS20>;
	Wed, 6 Jun 2001 14:28:26 -0400
Date: Wed, 6 Jun 2001 20:29:02 +0000
From: =?iso-8859-1?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jldomingo@crosswinds.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
Message-ID: <20010606202902.B1858@dardhal.mired.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <991815578.30689.1.camel@nomade>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 06 June 2001, at 10:19:30 +0200,
Xavier Bestel wrote:

> On 05 Jun 2001 23:19:08 -0400, Derek Glidden wrote:
> > On Wed, Jun 06, 2001 at 12:16:30PM +1000, Andrew Morton wrote:
> [...]
> Did you try to put twice as much swap as you have RAM ? (e.g. add a 512M
> swapfile to your box)
>
I'm not a kernel guru, neither I can even try to understand how an
operating system's memory management is designed or behaves. But I've some
questions and thoughs:

1. Is swap=2xRAM a desing issue, or just a recommendation to get best
results _based_ on current VM subsystem status ?
2. Wouldn't performance drop quickly when VM starts to swap
processes/pages to disk, instead of keeping them on RAM ?. Maybe having a
couple of GB worth of processes on disk is not very wyse.
3. Shouldn't an ideal VM manage swap space as an extension of system's RAM
(of course, taking into account that RAM is much faster than HD, and
nothing should be on swap if there is room enough on RAM ?.
4. Wouldn't you say that "adding more swap" (maybe 2xRAM is a
recommendation, maybe a temporary fix, maybe a design decission) is the
M$-way of fixing things ?. If there is a _real_ need for more swap to get
a well baheving system, let's add swap. But we shouldn't hide inner desing
and/or implementation problems under the "cheap multigigabyte disks"
argument.
5. AFAIK, kernel developers are well aware of current 2.4.x problems in
some areas. I don't think insisting on certain problems without providing
ideas, testing, support, and limiting to just blaming the authors is the
best way to go. Maybe kernel hackers are the most interested of all in
fixing all these issues ASAP.

Just some thoughts from someone unable to write C code and help fix this
mess ;).

--
José Luis Domingo López
Linux Registered User #189436     Debian GNU/Linux Potato (P166 64 MB RAM)
 
jdomingo EN internautas PUNTO org  => ¿ Spam ? Atente a las consecuencias
jdomingo AT internautas DOT   org  => Spam at your own risk

