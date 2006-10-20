Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992859AbWJTVvB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992859AbWJTVvB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 17:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992863AbWJTVvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 17:51:00 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:32133 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S2992804AbWJTVu7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 17:50:59 -0400
Message-ID: <453944BC.7090409@us.ibm.com>
Date: Fri, 20 Oct 2006 16:50:52 -0500
From: Brian King <brking@us.ibm.com>
Reply-To: brking@us.ibm.com
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Greg KH <greg@kroah.com>, Adam Belay <abelay@MIT.EDU>
Subject: Re: [PATCH] Block on access to temporarily unavailable pci device
 [version 3]
References: <20061017145146.GJ22289@parisc-linux.org> <20061019154128.GD2602@parisc-linux.org>
In-Reply-To: <20061019154128.GD2602@parisc-linux.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> Signed-off-by: Matthew Wilcox <matthew@wil.cx>

Acked-by: Brian King <brking@us.ibm.com>

I tried this out on my machine with an ipr adapter, where
I forced the adapter through BIST using ipr's reset_host
sysfs attribute, all the while continually reading pci
config space through sysfs in a loop. Everything looked
good.

Brian

-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
