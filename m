Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264202AbUFPQma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264202AbUFPQma (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 12:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264176AbUFPQkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 12:40:09 -0400
Received: from [213.146.154.40] ([213.146.154.40]:18076 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264211AbUFPQiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 12:38:50 -0400
Date: Wed, 16 Jun 2004 17:38:43 +0100 (BST)
From: jsimmons@pentafluge.infradead.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Jeff Garzik <jgarzik@pobox.com>, Zilvinas Valinskas <zilvinas@gemtek.lt>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Linux 2.6.7 (stty rows 50 columns 140 reports : No such device
 or address)
In-Reply-To: <1087394174.8697.229.camel@gaston>
Message-ID: <Pine.LNX.4.56.0406161737500.14901@pentafluge.infradead.org>
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org> 
 <20040616095805.GC14936@gemtek.lt>  <40D0432A.1080006@pobox.com>
 <1087394174.8697.229.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.3 (/)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (0.3 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 NO_REAL_NAME           From: does not include a real name
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The whole crap of tweaking the video modes when terminal size is
> changed with stty is not working properly imho. I don't like it, I
> don't like the way it's implemented and the drivers are not ready
> for it anyway since they lack a correct mode matching mecanism.
> 
> But that's one of James pet features so ...

There is a bug in stty. We should implement this in fbset as well. 
