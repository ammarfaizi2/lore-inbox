Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbTFBM0I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 08:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbTFBM0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 08:26:07 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:2524 "EHLO gaston")
	by vger.kernel.org with ESMTP id S262262AbTFBM0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 08:26:06 -0400
Subject: Re: [PATCH] pci bridge class code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Haverkamp <markh@osdl.org>,
       Patrick Mochel <mochel@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030602133258.A776@flint.arm.linux.org.uk>
References: <1054239461.28608.74.camel@markh1.pdx.osdl.net>
	 <20030529214044.B30661@flint.arm.linux.org.uk>
	 <1054287852.23562.2.camel@dhcp22.swansea.linux.org.uk>
	 <1054554964.535.35.camel@gaston>
	 <20030602133258.A776@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054557568.535.47.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 02 Jun 2003 14:39:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-02 at 14:32, Russell King wrote:

> That would not help the case when you have the "generic" bridge module
> loaded and the specific bridge driver as a loadable module.

Well... we could store the match score of the driver, and if a newer
driver comes with a better match, call a replace() callback in the
current owner to ask if it allows "live" replacement... But that's
far beyond my original idea though

Ben.

