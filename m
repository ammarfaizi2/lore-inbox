Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262180AbVC2Esd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbVC2Esd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 23:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbVC2Esd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 23:48:33 -0500
Received: from mail.kroah.org ([69.55.234.183]:58551 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262180AbVC2Es1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 23:48:27 -0500
Date: Mon, 28 Mar 2005 20:44:09 -0800
From: Greg KH <greg@kroah.com>
To: Zan Lynx <zlynx@acm.org>
Cc: Aaron Gyes <floam@sh.nu>, Kyle Moffett <mrmacman_g4@mac.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
Message-ID: <20050329044409.GF7362@kroah.com>
References: <1111886147.1495.3.camel@localhost> <490243b66dc7c3f592df7a7d0769dcb7@mac.com> <20050327181221.GB14502@kroah.com> <1112058277.14563.4.camel@localhost> <20050329033350.GA6990@kroah.com> <1112069010.12853.52.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112069010.12853.52.camel@localhost>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2005 at 09:03:29PM -0700, Zan Lynx wrote:
> On Mon, 2005-03-28 at 19:33 -0800, Greg KH wrote:
> > Also, the code has undergone a rewrite, fixing many issues, and changing
> > the way things work to tie more closely into the main driver core code.
> > As such, the class_simple code is now just gone, there is no such need
> > for it.  And as such, the new code contains the _GPL markings, as I do
> > not think that _anyone_ can try to claim that their code would not be a
> > derived work of Linux who wants to use it (as no other OS has such a
> > driver model interface.)
> 
> That does not really make sense, as the driver model code could be used
> for ndiswrapper, for example.  That would not make the Windows net
> drivers derived code of the Linux kernel.  ndiswrapper, yes it would be.
> Binary driver blobs, no.
> 
> ndiswrapper is a perfect example, in fact.  It is GPL, and implements an
> _interface_ to binary code that is not GPL.  

And do your lawyers deem ndiswrapper as something that is legal under
the GPL?  The ones I have talked to definitely do not feel that way.

Again, why are we, non-lawyers arguing about this.  If you work for a
company that deals with Linux kernel issues, and you have any questions
about the legality of _anything_, get a legal opinion.  Don't rely on
lkml for this.

greg k-h
