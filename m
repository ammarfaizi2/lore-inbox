Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314057AbSEMPVI>; Mon, 13 May 2002 11:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314058AbSEMPVH>; Mon, 13 May 2002 11:21:07 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:58117 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S314057AbSEMPVG>; Mon, 13 May 2002 11:21:06 -0400
Date: Mon, 13 May 2002 17:21:00 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Changelogs on kernel.org
Message-ID: <20020513152100.GA26406@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020513120953.GD4258@louise.pinerecords.com> <Pine.LNX.4.44.0205131556550.23542-100000@tuxedo.abo.fi> <20020513140821.GB5134@louise.pinerecords.com> <20020513144519.GC5134@louise.pinerecords.com> <20020513140623.GA10453@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2002, Greg KH wrote:

> What would be even _nicer_ is to remove the dependency on the changelog
> script entirely (right now you have to pipe the output through this perl
> script to get the results.)
> 
> The script that Linus (and others) uses can be found at:
> 	http://gkernel.bkbits.net:8080/BK-kernel-tools/anno/changelog@1.5?nav=index.html|src/

I'm a BK ignorant, and for robustness and programmer efficiency ;-)
reasons, I'd prefer not to call other software from a Perl script. Doing
that properly and handling errors correctly costs some dozens of lines
of code that we save when we're just building on what we have now. The
way it is now, we can deal with old and current ChangeLogs, we have the
verbose summary (overview, actually) and that's it. As these scripts are
not called more than several times a month, I fail to see the point in
eliminating the original bk stuff. Maybe someone uses Arch or Subversion
some day? Who knows? We have a well-defined input format that is easy
enough to parse.

Enough of this, I'm not about to waste more of my and your time :-)

(Now back to merging and optimizing the things that have been done to my
script...  thanks!)

-- 
Matthias Andree
