Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932652AbWKMSXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbWKMSXL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 13:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755317AbWKMSXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 13:23:11 -0500
Received: from verein.lst.de ([213.95.11.210]:21397 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1755315AbWKMSXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 13:23:10 -0500
Date: Mon, 13 Nov 2006 19:22:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
       Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>, Dominik Brodowski <linux@brodo.de>,
       Harald Welte <laforge@netfilter.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Jean Delvare <khali@linux-fr.org>
Subject: Re: feature-removal-schedule obsoletes
Message-ID: <20061113182238.GA29882@lst.de>
References: <45324658.1000203@gmail.com> <20061016133352.GA23391@lst.de> <200610242124.49911.arnd@arndb.de> <4543162B.7030701@drzeus.cx> <20061028105755.GA20103@lst.de> <45588C0F.60002@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45588C0F.60002@drzeus.cx>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -0.001 () BAYES_44
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2006 at 04:15:27PM +0100, Pierre Ossman wrote:
> Christoph Hellwig wrote:
> > On Sat, Oct 28, 2006 at 10:34:51AM +0200, Pierre Ossman wrote:
> >   
> >> What should be used to replace it? The MMC block driver uses it to
> >> manage the block device queue. I am not that intimate with the block
> >> layer so I do not know the proper fix.
> >>     
> >
> > kthread_create/kthread_run.  Here's a draft patch (and it's against
> > a rather old tree and untested due to lack of hardware so it really
> > should be considered just a draft).
> >
> >   
> 
> Patch looks ok to me and seems to work fine. Are you willing to sign off
> on it?

Sure, please add a

Signed-off-by: Christoph Hellwig <hch@lst.de>

to the patch.
