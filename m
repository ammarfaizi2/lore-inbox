Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264620AbTDZGwN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 02:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264621AbTDZGwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 02:52:13 -0400
Received: from dp.samba.org ([66.70.73.150]:57754 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264620AbTDZGwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 02:52:12 -0400
Date: Sat, 26 Apr 2003 16:30:39 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Christoph Hellwig <hch@infradead.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org, Jean Tourrilhes <jt@hpl.hp.com>,
       David Hinds <dhinds@sonic.net>
Subject: Re: Update to orinoco driver (2.4)
Message-ID: <20030426063039.GB14509@zax>
Mail-Followup-To: David Gibson <hermes@gibson.dropbear.id.au>,
	Christoph Hellwig <hch@infradead.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, Jean Tourrilhes <jt@hpl.hp.com>,
	David Hinds <dhinds@sonic.net>
References: <20030423054636.GG25455@zax> <20030423060520.GI25455@zax> <20030425153706.A2024@infradead.org> <20030426003018.GA14509@zax> <20030426062240.A19146@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030426062240.A19146@infradead.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 26, 2003 at 06:22:40AM +0100, Christoph Hellwig wrote:
> On Sat, Apr 26, 2003 at 10:30:18AM +1000, David Gibson wrote:
> > On Fri, Apr 25, 2003 at 03:37:06PM +0100, Christoph Hellwig wrote:
> > > > +static void __exit exit_hermes(void)
> > > > +{
> > > > +}
> > > > +
> > > >  module_init(init_hermes);
> > > > +module_exit(exit_hermes);
> > > 
> > > Please don't add exmpty functions without a reak good reason.
> > 
> > And the real good reason would be that the module can't be unloaded
> > without an exit function.
> 
> That braindamage fortunately is not true for 2.4 and still needs
> fixing for 2.5.

Removing one empty function is insufficient cause for me to maintain
separate 2.4 and 2.5 versions.  When and if this changes in 2.5, I'll
remove the function.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
