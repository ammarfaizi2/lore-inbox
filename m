Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316637AbSEQS1J>; Fri, 17 May 2002 14:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316638AbSEQS1I>; Fri, 17 May 2002 14:27:08 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:32644 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S316637AbSEQS1H>; Fri, 17 May 2002 14:27:07 -0400
Date: Fri, 17 May 2002 13:26:40 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200205171826.NAA44036@tomcat.admin.navo.hpc.mil>
To: phillips@bonn-fries.net, Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        Peter Chubb <peter@chubb.wattle.id.au>
Subject: Re: [PATCH] remove 2TB block device limit
In-Reply-To: <E178m48-00006Z-00@starship>
Cc: Anton Altaparmakov <aia21@cantab.net>,
        Peter Chubb <peter@chubb.wattle.id.au>,
        Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
        axboe@suse.de, akpm@zip.com.au, martin@dalecki.de,
        neilb@cse.unsw.edu.au
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> On Friday 17 May 2002 15:32, Jesse Pollard wrote:
> > And for the curious, the filesystems are SAMFS and SAMQFS on Sun E10000s.
> > We migrated the data from Cray NC1 filesystems with DMF - Cray data
> > migration facility (this took over 4 months. Would have taken only a month
> > or two, but we also had to accept new data at the same time).
> 
> Thanks for the fascinating data, however you left out one crucial piece of
> information: how many data bits in your processor?

Sorry - I did omit that..

Sun E10000s are Sparc based, and 64 bit. I realize this doesn't refer to
the 32 bit boundaries, but they were operating in 32 bit mode for the initial
installation (Solaris 2.6) and since some of the filesystem support was 3rd
party and didn't work when the kernel was in 64 bit mode.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
