Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbUKHVwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbUKHVwN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 16:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbUKHVwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 16:52:12 -0500
Received: from gate.crashing.org ([63.228.1.57]:904 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261257AbUKHVvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 16:51:39 -0500
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: Fix IO access in rivafb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: adaplas@pol.net
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200411081633.00645.adaplas@hotpop.com>
References: <200411080521.iA85LbG6025914@hera.kernel.org>
	 <1099893447.10262.154.camel@gaston> <200411081633.00645.adaplas@hotpop.com>
Content-Type: text/plain
Date: Tue, 09 Nov 2004 08:50:17 +1100
Message-Id: <1099950617.3946.163.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-08 at 16:33 +0800, Antonino A. Daplas wrote:

> Hmm, I'll ask Guido Guenther if he can test the changes. I think a different
> set of access macros for PPC might be a more preferrable solution. 

Well, I'd rather leave the registers Little Endian, but then, it will
clash with X which does put them into Big Endian mode, so that would
have to be restored all the time.

Ben.


