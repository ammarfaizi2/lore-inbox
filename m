Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262674AbRFMJeH>; Wed, 13 Jun 2001 05:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262660AbRFMJd5>; Wed, 13 Jun 2001 05:33:57 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:6916 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S262674AbRFMJdu>;
	Wed, 13 Jun 2001 05:33:50 -0400
Message-ID: <20010613004116.A26811@bug.ucw.cz>
Date: Wed, 13 Jun 2001 00:41:16 +0200
From: Pavel Machek <pavel@suse.cz>
To: ognen@gene.pbi.nrc.ca, linux-kernel@vger.kernel.org
Subject: Re: threading question
In-Reply-To: <Pine.LNX.4.30.0106121213570.24593-100000@gene.pbi.nrc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.30.0106121213570.24593-100000@gene.pbi.nrc.ca>; from ognen@gene.pbi.nrc.ca on Tue, Jun 12, 2001 at 12:24:04PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I am a summer student implementing a multi-threaded version of a very
> popular bioinformatics tool. So far it compiles and runs without problems
> (as far as I can tell ;) on Linux 2.2.x, Sun Solaris, SGI IRIX and Compaq
> OSF/1 running on Alpha. I have ran a lot of timing tests compared to the
> sequential version of the tool on all of these machines (most of them are
> dual-CPU, although I am also running tests on 12-CPU Solaris and 108 CPU
> SGI IRIX). On dual-CPU machines the speedups are as follows: my version
> is 1.88 faster than the sequential one on IRIX, 1.81 times on Solaris,
> 1.8 times on OSF/1, 1.43 times on Linux 2.2.x and 1.52 times on Linux 2.4
> kernel. Why are the numbers on Linux machines so much lower? It is
> the

But this is all different hw, no?

So dual cpu SPARC is more efficient than dual cpu i686. Maybe SPARCs
have faster RAM and slower cpus... 
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
