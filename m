Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbTFBLnD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 07:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbTFBLnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 07:43:02 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:42455 "EHLO gaston")
	by vger.kernel.org with ESMTP id S262179AbTFBLnA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 07:43:00 -0400
Subject: Re: [PATCH] pci bridge class code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk@arm.linux.org.uk>, Mark Haverkamp <markh@osdl.org>,
       Patrick Mochel <mochel@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1054287852.23562.2.camel@dhcp22.swansea.linux.org.uk>
References: <1054239461.28608.74.camel@markh1.pdx.osdl.net>
	 <20030529214044.B30661@flint.arm.linux.org.uk>
	 <1054287852.23562.2.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054554964.535.35.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 02 Jun 2003 13:56:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-30 at 11:44, Alan Cox wrote:

> The same is true of serveral hot docking bridges such as the one on the
> IBM TP600 and also of other devices which happen to be both a PCI-PCI
> bridge and have other magic stuck on them. 

Maybe we could find some way to prioritize matching ? It's a bit late now,
but well... if the match functions returned an integer, 0 beeing lower match,
we could have some kind of prioritization.

That way, a class match would have lower priority than a vendorID/deviceID
match, etc...

Ben.

