Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263993AbTDZAcA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 20:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264554AbTDZAcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 20:32:00 -0400
Received: from dp.samba.org ([66.70.73.150]:45002 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263993AbTDZAb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 20:31:59 -0400
Date: Sat, 26 Apr 2003 10:30:18 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Christoph Hellwig <hch@infradead.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org, Jean Tourrilhes <jt@hpl.hp.com>,
       David Hinds <dhinds@sonic.net>
Subject: Re: Update to orinoco driver (2.4)
Message-ID: <20030426003018.GA14509@zax>
Mail-Followup-To: David Gibson <hermes@gibson.dropbear.id.au>,
	Christoph Hellwig <hch@infradead.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, Jean Tourrilhes <jt@hpl.hp.com>,
	David Hinds <dhinds@sonic.net>
References: <20030423054636.GG25455@zax> <20030423060520.GI25455@zax> <20030425153706.A2024@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030425153706.A2024@infradead.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 25, 2003 at 03:37:06PM +0100, Christoph Hellwig wrote:
> > +static void __exit exit_hermes(void)
> > +{
> > +}
> > +
> >  module_init(init_hermes);
> > +module_exit(exit_hermes);
> 
> Please don't add exmpty functions without a reak good reason.

And the real good reason would be that the module can't be unloaded
without an exit function.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
