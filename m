Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270838AbUJUVPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270838AbUJUVPr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 17:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270809AbUJUVP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 17:15:27 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:63197 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S270969AbUJUVO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 17:14:57 -0400
Subject: Re: Linux 2.6.9-ac2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@davemloft.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041021123404.1d947ee0.davem@davemloft.net>
References: <1098379853.17095.160.camel@localhost.localdomain>
	 <20041021123404.1d947ee0.davem@davemloft.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098389527.17096.166.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 21 Oct 2004 21:12:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-10-21 at 20:34, David S. Miller wrote:
> 2.4.x will need this one as well, at least the AF_PACKET
> case.  Would you mind if I pushed that to Marcelo?

Not at all. Andrea has proposed fixing it a little differently. 
For 2.6 making remap_page_range DTRT itself is ok but for 2.4 the
vma isn't passed.


