Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263147AbSJHDGT>; Mon, 7 Oct 2002 23:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263149AbSJHDGT>; Mon, 7 Oct 2002 23:06:19 -0400
Received: from relay03.roc.frontiernet.net ([66.133.131.36]:42115 "EHLO
	relay03.roc.frontiernet.net") by vger.kernel.org with ESMTP
	id <S263147AbSJHDGS>; Mon, 7 Oct 2002 23:06:18 -0400
Date: Mon, 7 Oct 2002 23:12:04 -0400
From: Scott Mcdermott <vaxerdec@frontiernet.net>
To: linux-kernel@vger.kernel.org
Cc: Jan Hudec <bulb@ucw.cz>, Jesse Pollard <pollard@admin.navo.hpc.mil>,
       Oliver Neukum <oliver@neukum.name>,
       Helge Hafting <helgehaf@aitel.hist.no>,
       "Martin J. Bligh" <fmbligh@aracnet.com>
Subject: [OT] Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 - (NUMA))
Message-ID: <20021007231204.C3029@newbox.localdomain>
References: <m17yCIx-006hSwC@Mail.ZEDAT.FU-Berlin.DE> <m17yUp7-006fgcC@Mail.ZEDAT.FU-Berlin.DE> <20021007141122.GA14423@vagabond> <200210071001.22467.pollard@admin.navo.hpc.mil> <20021007153438.GA14993@vagabond>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021007153438.GA14993@vagabond>; from bulb@ucw.cz on Mon, Oct 07, 2002 at 05:34:38PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Hudec on Mon  7/10 17:34 +0200:
> Well, depends on what we want to measure. If it's on the begining of
> main, it measures library loading time. Then argument parsing, library
> initialization, X initialization etc. can be measured. All those parts
> should be timed so we can see where most time is spent and which can
> be sped up.

newer glibc prelinking support should help here a lot, according to
publshed time trials I have seen with and without the feature.
