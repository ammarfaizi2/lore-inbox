Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTJVVqT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 17:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbTJVVqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 17:46:19 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:7944 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261188AbTJVVqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 17:46:18 -0400
Date: Wed, 22 Oct 2003 22:46:10 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: jhf@rivenstone.net
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [FBDEV UPDATE] Newer patch.
In-Reply-To: <20031022205043.GA725@rivenstone.net>
Message-ID: <Pine.LNX.4.44.0310222242130.25125-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>     The attached patch is needed to make tdfxfb compile after
> applying this patch and also in test8-mm1 (so presumably in your older
> patch as well) (tdfxfb_imageblt calls cfb_imageblt).

Thanks.
 
>     tdfx is still badly broken in -mm1 both before and after replacing
> the older fbdev patch in -mm1 with your new one.  The behavior is much
> the same as reported with other drivers -- out of range frequencies
> and the same backtraces.  With fbset working I can set a new
> resolution which gets me a barely usable console -- lots of
> artifacts.

The out frequencies range problems existed before the api change for many 
drivers. Now that i2c support is being added to drivers this will go away.
The backtraces is from having debug info turned on. I haven't traced that 
problem yet. Are the artifacts from shrinking the screen or enlarging it?


