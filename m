Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262394AbVF2BEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262394AbVF2BEr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 21:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbVF2BBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 21:01:49 -0400
Received: from nome.ca ([65.61.200.81]:31676 "HELO gobo.nome.ca")
	by vger.kernel.org with SMTP id S262388AbVF2AxL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 20:53:11 -0400
Date: Tue, 28 Jun 2005 17:53:13 -0700
From: Mike Bell <kernel@mikebell.org>
To: David Lang <david.lang@digitalinsight.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Greg KH <greg@kroah.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
Message-ID: <20050629005312.GF4673@mikebell.org>
Mail-Followup-To: Mike Bell <kernel@mikebell.org>,
	David Lang <david.lang@digitalinsight.com>,
	Arjan van de Ven <arjan@infradead.org>, Greg KH <greg@kroah.com>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org
References: <200506271735.50565.dtor_core@ameritech.net> <20050627232559.GA7690@mikebell.org> <20050628074015.GA3577@kroah.com> <20050628090852.GA966@mikebell.org> <1119950487.3175.21.camel@laptopd505.fenrus.org> <20050628214929.GB23980@voodoo> <20050628222318.GC4673@mikebell.org> <20050628234310.GA29653@mail> <20050629001243.GD4673@mikebell.org> <Pine.LNX.4.62.0506281737340.24459@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0506281737340.24459@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 05:39:16PM -0700, David Lang wrote:
> worse yet, go way back in the archives and you will find that prior to 
> being merged into the kernel devfs supported two nameing schemes, the one 
> you see now and a compatability version that matched the standard /dev 
> names. one requirement for allowing it to be merged was to remove the 
> compatability set of names.

Yes, I vaguely remember. IIRC Linus was the one who mandated the use of
a directory based structure before devfs would be merged, though I think
the particular choice of names was not his fault.

Which is why I've asked people to seperate their distaste for the names
devfs uses from distaste for having a standard set of names.

Originally I was hoping that all those plans to move partition detection
into userspace using device-mapper would help eliminate people's
objections to devfs (AFAIK the devfs-style names hated most by far are
block devices, which are way too long), but it didn't work out that way.
