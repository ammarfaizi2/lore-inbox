Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267315AbUG1Q1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267315AbUG1Q1W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 12:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267310AbUG1QZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 12:25:06 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:46224 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S267304AbUG1QUB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 12:20:01 -0400
Date: Wed, 28 Jul 2004 20:21:26 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Greg Howard <ghoward@sgi.com>, Andrew Morton <akpm@osdl.org>
Cc: Greg Howard <ghoward@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Altix system controller communication driver
Message-ID: <20040728182126.GB14737@mars.ravnborg.org>
Mail-Followup-To: Greg Howard <ghoward@sgi.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <Pine.SGI.4.58.0407271457240.1364@gallifrey.americas.sgi.com> <20040728085737.26e0bfd2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728085737.26e0bfd2.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 08:57:37AM -0700, Andrew Morton wrote:
> Greg Howard <ghoward@sgi.com> wrote:
> >
> > Hi Andrew,
> > 
> > The following patch ("altix-system-controller-driver.patch")
> > implements a driver that allows user applications to access the system
> > controllers on SGI Altix machines.  It applies on top of the
> > 2.6.8-rc-mm1 patch.

[Lost the original mail..]

I would also recommend running it through sparse.
http://sparse.bkbits.net
davej has a .tar.gz package somewhere at www.codemonkey.org.uk.

I did not see any particular issue, but noticed no __user annotations
around copy_{to,from}_user().

	Sam
