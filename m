Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271753AbTHDOX5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 10:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271756AbTHDOX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 10:23:56 -0400
Received: from deepthought.resolution.de ([195.30.142.42]:44751 "EHLO
	deepthought.resolution.de") by vger.kernel.org with ESMTP
	id S271753AbTHDOWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 10:22:54 -0400
Message-ID: <1060006954.3f2e6c2a52f7f@corporate.resolution.de>
Date: Mon,  4 Aug 2003 16:22:34 +0200
From: Christian Reichert <c.reichert@resolution.de>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: mru@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
References: <20030804141548.5060b9db.skraw@ithnet.com> <yw1xsmohioah.fsf@users.sourceforge.net> <20030804152226.60204b61.skraw@ithnet.com> <1060004221.3f2e617d72d4f@corporate.resolution.de> <20030804154456.4ce45410.skraw@ithnet.com>
In-Reply-To: <20030804154456.4ce45410.skraw@ithnet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 192.147.51.120
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zitat von Stephan von Krawczynski <skraw@ithnet.com>:

> On Mon,  4 Aug 2003 15:37:01 +0200
> Christian Reichert <c.reichert@resolution.de> wrote:
> 
> > Hi !
> > 
> > the fundamental problem as i know it is that the FS design in unix is
> based
> > on a directory TREE structure - however if you implement hard links for 
> > directories you are breaking this strict treeu structure and can end up
> with 
> > loops/graphs.
> 
> This is just the same with softlinks, or not?
> 
Not really, symlinks are just files which contain the location of the 
directory - so the 'physical' structure still stays a tree ..

Cheers,
    Chris
