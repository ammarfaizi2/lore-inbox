Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVA1IqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVA1IqL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 03:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVA1IqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 03:46:11 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:46293 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S261210AbVA1IqC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 03:46:02 -0500
Date: Fri, 28 Jan 2005 09:45:58 +0100
From: David Weinehall <tao@debian.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Julien TINNES <julien.tinnes.NOSPAM@francetelecom.REMOVE.com>,
       John Richard Moser <nigelenki@comcast.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Patch 0/6  virtual address space randomisation
Message-ID: <20050128084558.GM17242@khan.acc.umu.se>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Julien TINNES <julien.tinnes.NOSPAM@francetelecom.REMOVE.com>,
	John Richard Moser <nigelenki@comcast.net>,
	linux-kernel@vger.kernel.org
References: <20050127101117.GA9760@infradead.org> <41F8D44D.9070409@francetelecom.REMOVE.com> <1106827050.5624.81.camel@laptopd505.fenrus.org> <41F927F2.2080100@comcast.net> <41F9425A.2030101@francetelecom.REMOVE.com> <1106856785.5624.132.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106856785.5624.132.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 09:13:04PM +0100, Arjan van de Ven wrote:
> On Thu, 2005-01-27 at 20:34 +0100, Julien TINNES wrote:
> > > 
> > > Yeah, if it came from PaX the randomization would actually be useful.
> > > Sorry, I've just woken up and already explained in another post.
> > > 
> > 
> > Please, no hard feelings.
> > 
> > Speaking about implementation of the non executable pages semantics on 
> > IA32, PaX and Exec-Shield are very different (well not that much since 
> > 2.6 in fact because PAGEEXEC is now "segmentation when I can").
> > But when it comes to ASLR it's pretty much the same thing.
> > 
> > The only difference may be the (very small) randomization of the brk() 
> > managed heap on ET_EXEC (which is probably the more "hackish" feature of 
> > PaX ASLR) but it seems that Arjan is even going to propose a patch for 
> > that (Is this in ES too ?).
> 
> Exec shield randomized brk() too yes.
> However that is a both more dangerous and more invasive change to do
> correctly (you have no idea how hard it is to get that right for
> emacs...) so that's reserved for the second batch of patches once this
> first batch is dealt with.

Oh, so you mean that we can both get a more secure system, *and* make
emacs stop working?  A win-win situation! =)


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
