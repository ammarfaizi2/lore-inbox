Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWAJU2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWAJU2P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 15:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbWAJU2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 15:28:14 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:60589 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932335AbWAJU2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 15:28:12 -0500
Subject: Re: File type by extension is evil (was Re: Why the DOS has many
	ntfs read and write driver,but the linux can't for a long time)
From: Lee Revell <rlrevell@joe-job.com>
To: "Bernhard R. Link" <brl@pcpool00.mathematik.uni-freiburg.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Olivier Galibert <galibert@pobox.com>
In-Reply-To: <20060110103259.GA9285@pcpool00.mathematik.uni-freiburg.de>
References: <5t06S-7nB-15@gated-at.bofh.it>
	 <1136824149.5785.75.camel@tara.firmix.at>
	 <1136824880.9957.55.camel@mindpipe> <200601091753.36485.oliver@neukum.org>
	 <20060109171411.GB67773@dspnet.fr.eu.org>
	 <20060110103259.GA9285@pcpool00.mathematik.uni-freiburg.de>
Content-Type: text/plain
Date: Tue, 10 Jan 2006 15:28:07 -0500
Message-Id: <1136924888.2007.81.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-10 at 11:32 +0100, Bernhard R. Link wrote:
> * Olivier Galibert <galibert@pobox.com> [060109 19:44]:
> > >From what I can see it does icons on non-executable entirely based on
> > the extension and nothing else on the first pass.
> > 
> > Not a bad strategy, too.  Doing a file(1) on everything can only be
> > slow given the random disk accesses it generates.  Maybe a file(1) as
> > a _second_ pass would work.
> 
> That may be a good strategy if you have user conditioned to all the
> effects you get by this (i.e. if you only focus on Windows users and
> want them provide with a system as broken as they know it) and programs
> adopted to cope with the most ill effects (ever asked why some browsers
> always foozle the name of downloaded files with some .html or the like?)
> 
> For everyone else looking at the file is the only sane way to know the type
> of file.

OK so it's prohibitively expensive to get the file type so this is not
something Nautilus should be doing to every file before even starting to
display the icons.

Lee

