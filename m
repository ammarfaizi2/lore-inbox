Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264390AbTHWRIx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 13:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264392AbTHWRIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 13:08:51 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:27652 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264388AbTHWRIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 13:08:22 -0400
Date: Sat, 23 Aug 2003 18:08:15 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Patrick Mochel <mochel@osdl.org>, Greg KH <greg@kroah.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: PCI PM & compatibility
Message-ID: <20030823180815.A1158@flint.arm.linux.org.uk>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Patrick Mochel <mochel@osdl.org>, Greg KH <greg@kroah.com>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1061649597.780.4.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1061649597.780.4.camel@gaston>; from benh@kernel.crashing.org on Sat, Aug 23, 2003 at 04:39:57PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 23, 2003 at 04:39:57PM +0200, Benjamin Herrenschmidt wrote:
> What about this patch to stay compatible with existing drivers
> implementing everything in save_state ?

And why are we now suspending device parents before their siblings???

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

