Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267313AbTBPRgq>; Sun, 16 Feb 2003 12:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267315AbTBPRgp>; Sun, 16 Feb 2003 12:36:45 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19985 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267313AbTBPRgp>; Sun, 16 Feb 2003 12:36:45 -0500
Date: Sun, 16 Feb 2003 17:46:37 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: John Levon <levon@movementarian.org>
Cc: Rahul Vaidya <rahulv@csa.iisc.ernet.in>,
       Zwane Mwaikambo <zwane@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: linux 2.5.53 not compiling
Message-ID: <20030216174637.C12489@flint.arm.linux.org.uk>
Mail-Followup-To: John Levon <levon@movementarian.org>,
	Rahul Vaidya <rahulv@csa.iisc.ernet.in>,
	Zwane Mwaikambo <zwane@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.50.0302161205240.578-100000@montezuma.mastecende.com> <Pine.SOL.3.96.1030216225625.25827E-100000@osiris.csa.iisc.ernet.in> <20030216174118.GA63890@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030216174118.GA63890@compsoc.man.ac.uk>; from levon@movementarian.org on Sun, Feb 16, 2003 at 05:41:18PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2003 at 05:41:18PM +0000, John Levon wrote:
> On Sun, Feb 16, 2003 at 10:57:50PM +0530, Rahul Vaidya wrote:
> 
> > I am getting the same error even for 2.5.61
> > 
> > Please cc any replies to rahulv@csa.iisc.ernet.in
> 
> Have you made a softlink for gcc ? Apparently that doesn't work well
> with recent gcc versions finding the headers...

It looks like buggy gcc configuration scripts - some parts of the compiler
seems to believe its internal headers are one place, whereas other parts
believe they're elsewhere.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

