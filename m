Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbTJYVyo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 17:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263060AbTJYVyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 17:54:44 -0400
Received: from griffin-can-au.getin2net.com ([203.43.225.34]:25604 "EHLO
	griffin-can-au.getin2net.com") by vger.kernel.org with ESMTP
	id S263057AbTJYVyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 17:54:43 -0400
Subject: Re: [Linux-fbdev-devel] VesaFB/OFFb power management.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0310222359470.25125-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0310222359470.25125-100000@phoenix.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1067118878.3570.17.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 25 Oct 2003 23:54:38 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-23 at 01:09, James Simmons wrote:
> I like to be able to suspend and resume these drivers. I noticed the 
> SA1100 driver does this using struct device_driver. Is it possible to do 
> this for VesaFB/OFFb ? What would be the bus field then?There isn't much you can do with offb. This is a completely static
driver that inherits from the HW as it was set by the firmware and
can't change anything later on... except the palette with some hacks
on some known cards...

Ben.

