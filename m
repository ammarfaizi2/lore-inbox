Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262542AbVAESPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262542AbVAESPr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 13:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbVAESPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 13:15:43 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:61213 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262542AbVAESNd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 13:13:33 -0500
Date: Wed, 5 Jan 2005 19:14:02 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: kconfig: avoid temporary file
Message-ID: <20050105181402.GA15675@mars.ravnborg.org>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <20041230235146.GA9450@mars.ravnborg.org> <200501030155.05203.zippel@linux-m68k.org> <20050103051002.GB8113@mars.ravnborg.org> <200501051340.31794.zippel@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501051340.31794.zippel@linux-m68k.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 01:40:31PM +0100, Roman Zippel wrote:
> Hi,
> 
> On Monday 03 January 2005 06:10, Sam Ravnborg wrote:
> 
> > Next step is to integrate Petr Baudis patch to link lxdialog with mconf.
> 
> I had two major problems with his patch:
> - it didn't resize when the terminal changed.
Resize support will not be added until it works.

> - window layering, old windows are not removed and just drawn over (this was 
> especially a problem with help texts).
Did not see it as a problem as such - will try to play with it a bit
more. I have the original patch more or less blindly applied. For an
acceptable version a parts of it will be redone.

I also noticed that ESC was not working as usual.

	Sam
