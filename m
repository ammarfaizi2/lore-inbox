Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268295AbUHXUpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268295AbUHXUpt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 16:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268300AbUHXUps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 16:45:48 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:25693 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S268295AbUHXUpf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 16:45:35 -0400
Date: Tue, 24 Aug 2004 22:46:11 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Sam Ravnborg <sam@ravnborg.org>, Mikael Pettersson <mikpe@csd.uu.se>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Shouldn't kconfig defaults match recommendations in help text?
Message-ID: <20040824204611.GB26136@mars.ravnborg.org>
Mail-Followup-To: Jesper Juhl <juhl-lkml@dif.dk>,
	Sam Ravnborg <sam@ravnborg.org>, Mikael Pettersson <mikpe@csd.uu.se>,
	LKML <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0408232347380.3767@dragon.hygekrogen.localhost> <16683.22576.781038.756277@alkaid.it.uu.se> <Pine.LNX.4.61.0408241859420.2770@dragon.hygekrogen.localhost> <20040824182930.GA7260@mars.ravnborg.org> <Pine.LNX.4.61.0408242129130.2770@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0408242129130.2770@dragon.hygekrogen.localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 09:33:09PM +0200, Jesper Juhl wrote:
> 
> Which brings me to another thing regarding configs and defaults - there 
> does not seem to be much relation between the defaults in the various 
> Kconfig files and the settings in arch/<foo>/defconfig which puzzles me, 
> especially since "make defconfig" seems to use the stuff from 
> arch/<foo>/defconfig and not what's specified in Kconfig...
> Wouldn't it make sense to update the defconfig's to match the Kconfig's 
> when I make these changes?

defconfig is only subject for changes by arch-maintainers.
And defaults provided in Kconfig is mainly valid for i386 anyway -
so are the Kconfig help text.

	Sam
