Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbULIP2C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbULIP2C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 10:28:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbULIP1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 10:27:45 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:55244 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261540AbULIP1e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 10:27:34 -0500
Date: Fri, 10 Dec 2004 02:27:26 +1100
From: Greg Banks <gnb@sgi.com>
To: John Levon <levon@movementarian.org>
Cc: Akinobu Mita <amgta@yacht.ocn.ne.jp>, Philippe Elie <phil.el@wanadoo.fr>,
       linux-kernel@vger.kernel.org
Subject: Re: [mm patch] oprofile: backtrace operation does not initialized
Message-ID: <20041209152726.GE6987@sgi.com>
References: <200412081830.51607.amgta@yacht.ocn.ne.jp> <20041209015024.GG4239@sgi.com> <200412092322.27096.amgta@yacht.ocn.ne.jp> <200412092353.53634.amgta@yacht.ocn.ne.jp> <20041209145519.GA78695@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041209145519.GA78695@compsoc.man.ac.uk>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2004 at 02:55:19PM +0000, John Levon wrote:
> On Thu, Dec 09, 2004 at 11:53:53PM +0900, Akinobu Mita wrote:
> 
> > Or, It may be better to revert the return type of oprofile_arch_init()
> > from "void" to "int"  to get the result of initialization.
> 
> I've also lost track of why we don't return -ENODEV from the
> arch_init().

I didn't see a good reason for that change either.  Version 0.2
of the callgraph patch had the int return and worked fine.  Let's
go back.

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.
