Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbVCNRnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbVCNRnS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 12:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVCNRnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 12:43:18 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:45730 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261646AbVCNRkV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 12:40:21 -0500
Subject: Re: [PATCH] remove dead cyrix/centaur mtrr init code
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
In-Reply-To: <1110400574.3072.233.camel@localhost.localdomain>
References: <200503081937.j28Jb4Vd020597@hera.kernel.org>
	 <1110387326.28860.199.camel@localhost.localdomain>
	 <20050309190920.GA4044@pclin040.win.tue.nl>
	 <1110400574.3072.233.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110821900.15927.134.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 14 Mar 2005 17:38:21 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-03-09 at 20:36, Alan Cox wrote:
> On Mer, 2005-03-09 at 19:09, Andries Brouwer wrote:
> > The moment you report that the follow-up patch is fine, we can
> > remove the #if 0 and insert the initcalls instead.
> > 
> > So, all is well today, and we are waiting for your report.
> 
> Ok works for me. I'll let you know ASAP.

Winchip works as well if you call the ->init, and it is much happier as
a result.

