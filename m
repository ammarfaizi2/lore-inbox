Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315529AbSEWKHU>; Thu, 23 May 2002 06:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316170AbSEWKHT>; Thu, 23 May 2002 06:07:19 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:34576 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S315529AbSEWKHS>; Thu, 23 May 2002 06:07:18 -0400
Date: Thu, 23 May 2002 12:07:19 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: mgross@unix-os.sc.intel.com, "Vamsi Krishna S." <vamsi_krishna@in.ibm.com>,
        Gross Mark <mark.gross@intel.com>, linux-kernel@vger.kernel.org,
        r1vamsi@in.ibm.com
Subject: Re: PATCH Multithreaded core dumps for the 2.5.17 kernel  was ....RE:    PATCH Multithreaded core dump support for the 2.5.14 (aO
Message-ID: <20020523100718.GC11756@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200205222043.g4MKhsw06808@unix-os.sc.intel.com> <E17AeGS-0002wv-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I think that although my tcore_suspend_threads and Pavel's freeze_processes 
> > have similar results, I don't think using Pavel's approach for the core dump 
> > is a good idea.
> 
> Migrating a task to a specific processor is also remarkably related. How does
> it wash out if the suspend thread/freeze process stuff works by migrating
> all the processes to a CPU that doesnt exist ?

That does not solve locks problem.
									Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
