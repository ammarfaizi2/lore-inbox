Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262765AbVBYR7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbVBYR7P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 12:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbVBYR7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 12:59:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:48310 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262765AbVBYR7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 12:59:13 -0500
Date: Fri, 25 Feb 2005 17:59:04 +0000 (GMT)
From: James Simmons <jsimmons@www.infradead.org>
X-X-Sender: jsimmons@pentafluge.infradead.org
To: linux-fbdev-devel@lists.sourceforge.net
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: 2.6.11-rc5
In-Reply-To: <20050225172945.GA31211@suse.de>
Message-ID: <Pine.LNX.4.56.0502251758370.20213@pentafluge.infradead.org>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org>
 <20050224145049.GA21313@suse.de> <1109287708.15026.25.camel@gaston>
 <20050225070813.GA13735@suse.de> <1109316551.14993.63.camel@gaston>
 <20050225172945.GA31211@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> cfb_imageblit(320) dst1 fa51a800 base e0b80000 bitstart 1999a800
> fast_imageblit(237) s daea4000 dst1 fa51a800
> fast_imageblit(269) j 1 fa51a800 0
> Unable to handle kernel paging request at virtual address fa51a800
> 
> is bitstart incorrect or is the thing just not (yet) mapped?

Looks like the screen_base is not mapped to.

