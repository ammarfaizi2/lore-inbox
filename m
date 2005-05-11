Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbVEKE75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbVEKE75 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 00:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVEKE75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 00:59:57 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:47169 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261879AbVEKE74
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 00:59:56 -0400
Date: Wed, 11 May 2005 07:01:19 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: cpclark@xmission.com
Cc: Kumar Gala <kumar.gala@freescale.com>,
       linuxppc-embedded list <linuxppc-embedded@ozlabs.org>,
       Tom Rini <trini@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PPC uImage build not reporting correctly
Message-ID: <20050511050119.GC8025@mars.ravnborg.org>
References: <Pine.LNX.4.63.0505061718380.6288@xmission.xmission.com> <b0aede90eb15562c0dd5a44c10d1b965@freescale.com> <20050510042828.GA8398@mars.ravnborg.org> <Pine.LNX.4.63.0505100420380.8140@xmission.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0505100420380.8140@xmission.xmission.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >
> > Looks ok - but I do not see why use of $(shell ...) did not work out.
> 
> As I understand it, the $(shell ...) construct doesn't "work" in the case 
> cited above because make evaluates/expands the $(shell ...) stuff while it 
> is parsing the makefile and building the command list--i.e. before it has 
> issued any commands to build anything.  What seems to be desired in this 
> case is a file-existence test which runs "inline" with respect to the 
> preceding commands.  The use of $(shell ...) inside a command 
> subverts/preempts that natural sequence.  I think. :-)

That explains it - thanks!

	Sam
