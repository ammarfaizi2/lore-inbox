Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261950AbUKUJmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbUKUJmh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 04:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbUKUJmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 04:42:36 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:16444 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261950AbUKUJm3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 04:42:29 -0500
Date: Sun, 21 Nov 2004 10:43:08 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: Sam Ravnborg <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Why INSTALL_PATH is not /boot by default?
Message-ID: <20041121094308.GA7911@mars.ravnborg.org>
Mail-Followup-To: Blaisorblade <blaisorblade_spam@yahoo.it>,
	Sam Ravnborg <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>
References: <200411160127.15471.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411160127.15471.blaisorblade_spam@yahoo.it>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 01:27:15AM +0100, Blaisorblade wrote:
> This line, in the main Makefile, is commented:
> 
> export  INSTALL_PATH=/boot
> 
> Why? It seems pointless, since almost everything has been for ages requiring 
> this settings, and distros' versions of installkernel have been taking an 
> empty INSTALL_PATH as meaning /boot for ages (for instance Mandrake). It's 
> maybe even mandated by the FHS (dunno).
> 
> Is there any reason I'm missing?

Changing this may have impact on default behaviour of some versions of
installkernel.
If /boot is ok for other than just i386 we can give it a try.

	Sam
