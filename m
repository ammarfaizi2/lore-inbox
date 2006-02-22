Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932471AbWBVI24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbWBVI24 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 03:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWBVI24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 03:28:56 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:47341 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932471AbWBVI24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 03:28:56 -0500
Subject: Re: 2.6.16-rc4: known regressions
From: Arjan van de Ven <arjan@infradead.org>
To: Kay Sievers <kay.sievers@suse.de>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Greg KH <gregkh@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Robert Love <rml@novell.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>
In-Reply-To: <20060221225718.GA12480@vrfy.org>
References: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org>
	 <20060217231444.GM4422@stusta.de>
	 <84144f020602190306o3149d51by82b8ccc6108af012@mail.gmail.com>
	 <20060219145442.GA4971@stusta.de> <1140383653.11403.8.camel@localhost>
	 <20060220010205.GB22738@suse.de> <1140562261.11278.6.camel@localhost>
	 <20060221225718.GA12480@vrfy.org>
Content-Type: text/plain
Date: Wed, 22 Feb 2006 09:28:06 +0100
Message-Id: <1140596886.2979.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-21 at 23:57 +0100, Kay Sievers wrote:
> On Wed, Feb 22, 2006 at 12:51:01AM +0200, Pekka Enberg wrote:
> > On Sun, 2006-02-19 at 17:02 -0800, Greg KH wrote:
> > > If you revert this one patch, on top of a clean 2.6.16-rc4, do things
> > > start working for you again?
> > 
> > Okey dokey, bisecting with mrproper took little longer than expected but
> > I found the bad changeset:
> > 
> > 033b96fd30db52a710d97b06f87d16fc59fee0f1 is first bad commit
> > diff-tree 033b96fd30db52a710d97b06f87d16fc59fee0f1 (from 0f76e5acf9dc788e664056dda1e461f0bec93948)
> > Author: Kay Sievers <kay.sievers@suse.de>
> > Date:   Fri Nov 11 06:09:55 2005 +0100
> > 
> >     [PATCH] remove mount/umount uevents from superblock handling
> 
> Upgrade HAL, it's too old for that kernel.


thats not a good answer ;)


