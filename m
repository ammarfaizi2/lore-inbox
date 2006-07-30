Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbWG3SrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbWG3SrA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 14:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbWG3SrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 14:47:00 -0400
Received: from ns.suse.de ([195.135.220.2]:53741 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932427AbWG3SrA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 14:47:00 -0400
From: Andi Kleen <ak@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Building external modules against objdirs
Date: Sun, 30 Jul 2006 20:42:09 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, agruen@suse.de
References: <200607301846.07797.ak@suse.de> <200607301949.41165.ak@suse.de> <20060730183430.GB30278@mars.ravnborg.org>
In-Reply-To: <20060730183430.GB30278@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607302042.09620.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 July 2006 20:34, Sam Ravnborg wrote:
> On Sun, Jul 30, 2006 at 07:49:41PM +0200, Andi Kleen wrote:
> > 
> > > Can you check that you really did a 'make prepare' in the relevant
> > > output directory. Previously only the make *config step was needed.
> > 
> > The output directory is a full build (configuration + make without any targets).
> > Is that not enough anymore? 
> > 
> > Anyways after a make prepare it seems to work - thanks - but I think that
> > should be really done as part of the standard build like it was in 2.6.17.
> It could also be a mis-merge of some suse patches.
> Is this with a vanilla kernel or a suse patched one?

vanilla kernel + my x86-64 patchkit, but it doesn't really change 
anything significant in Makefiles

-Andi
