Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268071AbUG2QFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268071AbUG2QFX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 12:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267572AbUG2QFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 12:05:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6029 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268307AbUG2QDD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 12:03:03 -0400
Date: Thu, 29 Jul 2004 12:02:15 -0400
From: Alan Cox <alan@redhat.com>
To: Doug Maxey <dwm@austin.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Fix ide probe double detection
Message-ID: <20040729160215.GB20537@devserv.devel.redhat.com>
References: <1091071364.13625.37.camel@gaston> <200407291556.i6TFuc7U015149@falcon10.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407291556.i6TFuc7U015149@falcon10.austin.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 10:56:38AM -0500, Doug Maxey wrote:
> One strategy would be to reverse the order of probes, doing drive 1 first,
> then drive 0.  When I was working IDE in AIX, we had some ATAPI devices that
> were recalcitrant until the strategy was switched to 1,0 order

I'm missing something here - how is this helpful when the slave bit is simply
not decoded and you get master both times ?

