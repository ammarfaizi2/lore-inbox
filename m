Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbVCaUkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbVCaUkY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 15:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbVCaUkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 15:40:24 -0500
Received: from mail.kroah.org ([69.55.234.183]:48271 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261819AbVCaUkT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 15:40:19 -0500
Date: Thu, 31 Mar 2005 12:25:22 -0800
From: Greg KH <greg@kroah.com>
To: Prakash Punnoor <prakashp@arcor.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, "Randy.Dunlap" <rddunlap@osdl.org>,
       sean <seandarcy2@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: BK snapshots removed from kernel.org?
Message-ID: <20050331202522.GA971@kroah.com>
References: <200503271414.33415.nbensa@gmx.net> <20050327210218.GA1236@ip68-4-98-123.oc.oc.cox.net> <200503281226.48146.nbensa@gmx.net> <4248258A.1060604@osdl.org> <d2fr2e$lvo$1@sea.gmane.org> <424B72CC.8030801@osdl.org> <424B79E6.90300@pobox.com> <20050331060201.GB25365@kroah.com> <424BE242.1020302@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424BE242.1020302@arcor.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2005 at 01:42:58PM +0200, Prakash Punnoor wrote:
> Greg KH schrieb:
> > On Wed, Mar 30, 2005 at 11:17:42PM -0500, Jeff Garzik wrote:
> > 
> >>Should hopefully just be changing get-version.pl ...
> > 
> > 
> > Nah, this simple patch to snapshot fixes it.
> > 
> > I've also generated the 2.6.12-rc1-bk3 snapshot and fixed up the
> > directory on kernel.org so it should now work properly if you apply the
> > patch.
> 
> Hi, have the incremental patches been fixes as well? Last is 2.6.11-bk9 to bk10...

incrementals never worked for the -rc bk snapshots, as I don't think
they were turned on (they are automatically generated with some other
script somewhere...)

I just make them myself when I need them, I have a script around here
for that...

bah, drowning in helper scripts, the story of a programmer's life.

greg k-h
