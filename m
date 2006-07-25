Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbWGYPPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbWGYPPk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 11:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWGYPPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 11:15:40 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:24557 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932426AbWGYPPj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 11:15:39 -0400
Date: Tue, 25 Jul 2006 17:15:20 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where does kernel/resource.c.1 file come from?
Message-ID: <20060725151520.GA15681@mars.ravnborg.org>
References: <200607251554.50484.eike-kernel@sf-tec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607251554.50484.eike-kernel@sf-tec.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 03:54:45PM +0200, Rolf Eike Beer wrote:
> Hi,
> 
> I'm playing around with my local copy of linux-2.6 git tree. I'm building 
> everything to a separate directory using O= to keep "git status" silent.
> 
> After building I sometimes find a file kernel/resource.c.1 in my git tree that 
> doesn't really belong there. Who is generating this file, for what reason and 
> why doesn't it get created in my output directory?

I have never seen this myself so a bit puzzled???
Is it only kernel/resource.c that generates the .1 file - or is it
somethign that is general?
Can you also try to make sure that this file is generated as part of the
build process. git status before and after should do it.

If you can relaiably provoke it output of make V=1 would be usefull.

	Sam
