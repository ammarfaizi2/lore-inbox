Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263305AbTIVT45 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 15:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263306AbTIVT45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 15:56:57 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:7175 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263305AbTIVT44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 15:56:56 -0400
Date: Mon, 22 Sep 2003 21:56:54 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: John Levon <levon@movementarian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unknown symbols loading modules under 2.6.x
Message-ID: <20030922195654.GA983@mars.ravnborg.org>
Mail-Followup-To: John Levon <levon@movementarian.org>,
	linux-kernel@vger.kernel.org
References: <E1A1TE1-00075s-00@speech.braille.uwo.ca> <20030922091800.3b2532ec.rddunlap@osdl.org> <20030922163432.GA3208@mars.ravnborg.org> <20030922164916.GA12729@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030922164916.GA12729@compsoc.man.ac.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 22, 2003 at 05:49:16PM +0100, John Levon wrote:
> On Mon, Sep 22, 2003 at 06:34:32PM +0200, Sam Ravnborg wrote:
> 
> > Also make sure that you use kbuild when compiling your module.
> 
> Talking of which, how hard would it be to fix make clean and make
> modules_install for this ?
> 
> Current make clean with SUBDIRS set still cleans out the entire kernel
> tree, and modules_install wipes out the entire target modules directory.
> 
> It would be nice to see at least the latter fixed so there's a simple
> way for building modules against 2.6 series (especially since it's
> already way nicer than the contortions for 2.2 and 2.4).

I'm planning to looking into building external modules as next step.
Linus just merged the "Separate output directory" patch, and
proper support for external modules is a natural next step.

So if nothing shows up in the next few days I wil try looking into that.
I have a few mails saved on the topic, but the above was also good inputs.

	Sam
