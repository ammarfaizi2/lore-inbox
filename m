Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262632AbVBYHCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262632AbVBYHCa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 02:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbVBYHC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 02:02:29 -0500
Received: from isilmar.linta.de ([213.239.214.66]:61160 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S262632AbVBYHC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 02:02:28 -0500
Date: Fri, 25 Feb 2005 08:02:26 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Jeff Garzik <jgarzik@pobox.com>, Pavel Roskin <proski@gnu.org>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [Orinoco-devel] Re: [8/14] Orinoco driver updates - PCMCIA initialization cleanups
Message-ID: <20050225070226.GA30541@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Jeff Garzik <jgarzik@pobox.com>, Pavel Roskin <proski@gnu.org>,
	Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
References: <20050224035524.GC32001@localhost.localdomain> <20050224035650.GD32001@localhost.localdomain> <20050224035718.GE32001@localhost.localdomain> <20050224035804.GF32001@localhost.localdomain> <20050224035957.GH32001@localhost.localdomain> <20050224040024.GI32001@localhost.localdomain> <20050224040052.GJ32001@localhost.localdomain> <20050224065527.GA8931@isilmar.linta.de> <421D8241.9020608@pobox.com> <20050225050310.GF10725@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050225050310.GF10725@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2005 at 04:03:10PM +1100, David Gibson wrote:
> On Thu, Feb 24, 2005 at 02:29:05AM -0500, Jeff Garzik wrote:
> > Dominik Brodowski wrote:
> > >>@@ -184,6 +186,7 @@
> > >>	dev_list = link;
> > >>
> > >>	client_reg.dev_info = &dev_info;
> > >>+	client_reg.Attributes = INFO_IO_CLIENT | INFO_CARD_SHARE;
> > >
> > >
> > >That's not needed any longer for 2.6.
> > 
> > So who wants to send the incremental update patch?  :)
> 
> Guess I will.  See below.
> 
> Any particular reason the field and associated constants haven't been
> exunged from the tree, since they're no longer used?

To keep external drivers compiling -- it'll be removed soon, though.

	Dominik
