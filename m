Return-Path: <linux-kernel-owner+w=401wt.eu-S1751319AbWLLNHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWLLNHq (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 08:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWLLNHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 08:07:46 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:57379 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbWLLNHp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 08:07:45 -0500
Subject: Re: [PATCH/RFC] Delete JFFS (version 1)
From: David Woodhouse <dwmw2@infradead.org>
To: Josh Boyer <jwboyer@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       jffs-dev@axis.com
In-Reply-To: <625fc13d0612120506g3e4d1e54w8549989faf63031a@mail.gmail.com>
References: <457EA2FE.3050206@garzik.org>
	 <625fc13d0612120456p1d74663fp21e40ee84a8819bc@mail.gmail.com>
	 <457EA86B.5010407@garzik.org>
	 <625fc13d0612120506g3e4d1e54w8549989faf63031a@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 12 Dec 2006 13:07:40 +0000
Message-Id: <1165928860.5253.624.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-12 at 07:06 -0600, Josh Boyer wrote:
> On 12/12/06, Jeff Garzik <jeff@garzik.org> wrote:
> > Josh Boyer wrote:
> > > On 12/12/06, Jeff Garzik <jeff@garzik.org> wrote:
> > >> I have created the 'kill-jffs' branch of
> > >> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git that
> > >> removes fs/jffs.
> > >>
> > >> I argue that you can count the users (who aren't on 2.4) on one hand,
> > >> and developers don't seem to have cared for it in ages.
> > >>
> > >> People are already talking about jffs2 replacements, so I propose we zap
> > >> jffs in 2.6.21.
> > >
> > > I'm usually all for killing broken code, but JFFS isn't really broken
> > > is it?  Is there some burden it's causing by being in the kernel at
> > > the moment?
> >
> > It's always been the case that we remove Linux kernel code when the
> > number of users (and more importantly, developers) drops to near-nil.
> >
> > Every line of code is one more place you have to audit when code
> > changes, one more place to update each time the VFS API is touched.
> 
> Ok, I can buy that.
> 
> >
> > When it's more likely to get struck by lightning than encounter
> > filesystem X on a random hard drive in the field, filesystem X need not
> > be in the kernel.
> 
> Or flash chip in this case ;)

More to the point, people have occasionally actually _used_ JFFS instead
of JFFS2. I'm all for removing it now.

-- 
dwmw2

