Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264619AbTDZFKd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 01:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264620AbTDZFKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 01:10:33 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:1040 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264619AbTDZFKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 01:10:32 -0400
Date: Sat, 26 Apr 2003 06:22:40 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Gibson <hermes@gibson.dropbear.id.au>,
       Christoph Hellwig <hch@infradead.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org, Jean Tourrilhes <jt@hpl.hp.com>,
       David Hinds <dhinds@sonic.net>
Subject: Re: Update to orinoco driver (2.4)
Message-ID: <20030426062240.A19146@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Gibson <hermes@gibson.dropbear.id.au>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, Jean Tourrilhes <jt@hpl.hp.com>,
	David Hinds <dhinds@sonic.net>
References: <20030423054636.GG25455@zax> <20030423060520.GI25455@zax> <20030425153706.A2024@infradead.org> <20030426003018.GA14509@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030426003018.GA14509@zax>; from hermes@gibson.dropbear.id.au on Sat, Apr 26, 2003 at 10:30:18AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 26, 2003 at 10:30:18AM +1000, David Gibson wrote:
> On Fri, Apr 25, 2003 at 03:37:06PM +0100, Christoph Hellwig wrote:
> > > +static void __exit exit_hermes(void)
> > > +{
> > > +}
> > > +
> > >  module_init(init_hermes);
> > > +module_exit(exit_hermes);
> > 
> > Please don't add exmpty functions without a reak good reason.
> 
> And the real good reason would be that the module can't be unloaded
> without an exit function.

That braindamage fortunately is not true for 2.4 and still needs
fixing for 2.5.

