Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263866AbTFHVTy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 17:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263867AbTFHVTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 17:19:54 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54541 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263866AbTFHVTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 17:19:53 -0400
Date: Sun, 8 Jun 2003 22:33:18 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Matthew Wilcox <willy@debian.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-kernel@vger.kernel.org,
       David Mosberger <davidm@hpl.hp.com>
Subject: Re: [PATCH] [3/3] PCI segment support
Message-ID: <20030608223318.C9520@flint.arm.linux.org.uk>
Mail-Followup-To: Matthew Wilcox <willy@debian.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	linux-kernel@vger.kernel.org, David Mosberger <davidm@hpl.hp.com>
References: <20030407234411.GT23430@parcelfarce.linux.theplanet.co.uk> <20030408203824.A27019@jurassic.park.msu.ru> <20030608164351.GI28581@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030608164351.GI28581@parcelfarce.linux.theplanet.co.uk>; from willy@debian.org on Sun, Jun 08, 2003 at 05:43:51PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 08, 2003 at 05:43:51PM +0100, Matthew Wilcox wrote:
> I envisage ia64 will always turn on CONFIG_PCI_DOMAINS but x86 might
> well have it as a user question.  I suspect most architectures would
> never turn it on (yeah, I'm going to design an embedded ARM box with
> multiple PCI domains.  sure.)

Don't be so sure.  There's already ARM implementations where there are
multiple PCI buses hanging off the host bridge - mostly stuff from Intel
though.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

