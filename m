Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbTFBOLx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 10:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbTFBOLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 10:11:53 -0400
Received: from air-2.osdl.org ([65.172.181.6]:20365 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262348AbTFBOLw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 10:11:52 -0400
Subject: Re: [PATCH] pci bridge class code
From: Mark Haverkamp <markh@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Russell King <rmk@arm.linux.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pat Mochel <mochel@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1054557568.535.47.camel@gaston>
References: <1054239461.28608.74.camel@markh1.pdx.osdl.net>
	 <20030529214044.B30661@flint.arm.linux.org.uk>
	 <1054287852.23562.2.camel@dhcp22.swansea.linux.org.uk>
	 <1054554964.535.35.camel@gaston>
	 <20030602133258.A776@flint.arm.linux.org.uk>
	 <1054557568.535.47.camel@gaston>
Content-Type: text/plain
Organization: 
Message-Id: <1054563956.20579.10.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 02 Jun 2003 07:25:56 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-02 at 05:39, Benjamin Herrenschmidt wrote:
> On Mon, 2003-06-02 at 14:32, Russell King wrote:
> 
> > That would not help the case when you have the "generic" bridge module
> > loaded and the specific bridge driver as a loadable module.
> 
> Well... we could store the match score of the driver, and if a newer
> driver comes with a better match, call a replace() callback in the
> current owner to ask if it allows "live" replacement... But that's
> far beyond my original idea though

That is something I was considering also. I'm not sure how big of a
change it would be yet.  I started looking at it a little bit on Friday.

Mark.

-- 
Mark Haverkamp <markh@osdl.org>

