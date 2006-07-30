Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbWG3Sec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWG3Sec (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 14:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWG3Sec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 14:34:32 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:11450 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932411AbWG3Seb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 14:34:31 -0400
Date: Sun, 30 Jul 2006 20:34:30 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, agruen@suse.de
Subject: Re: Building external modules against objdirs
Message-ID: <20060730183430.GB30278@mars.ravnborg.org>
References: <200607301846.07797.ak@suse.de> <20060730175130.GA23665@mars.ravnborg.org> <200607301949.41165.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607301949.41165.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2006 at 07:49:41PM +0200, Andi Kleen wrote:
> 
> > Can you check that you really did a 'make prepare' in the relevant
> > output directory. Previously only the make *config step was needed.
> 
> The output directory is a full build (configuration + make without any targets).
> Is that not enough anymore? 
> 
> Anyways after a make prepare it seems to work - thanks - but I think that
> should be really done as part of the standard build like it was in 2.6.17.
It could also be a mis-merge of some suse patches.
Is this with a vanilla kernel or a suse patched one?

If the latter can I then have a full copy to look at.

	Sam
