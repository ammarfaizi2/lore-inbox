Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262472AbTI0PyN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 11:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbTI0PyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 11:54:13 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:7810
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262472AbTI0PyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 11:54:11 -0400
Date: Sat, 27 Sep 2003 11:53:56 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Eric Balsa <eric@onewest.net>
Subject: Re: [PATCH][2.6] fix atp870u boot oops
In-Reply-To: <1064669135.2002.1.camel@mulgrave>
Message-ID: <Pine.LNX.4.53.0309271152200.16940@montezuma.fsmlabs.com>
References: <001701c3845e$f3e4b470$fad11341@corporate.onewest.net> 
 <Pine.LNX.4.53.0309270302110.16940@montezuma.fsmlabs.com>
 <1064669135.2002.1.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Sep 2003, James Bottomley wrote:

> On Sat, 2003-09-27 at 04:27, Zwane Mwaikambo wrote:
> > The driver's probe function accesses uninitialised data. I also made it 
> > use pci_get_device instead of pci_find_device to bump the refcount on the 
> > pci devices it finds.
> 
> I don't suppose you'd like to fix this properly?  i.e. convert the
> driver to the sysfs based pci probing infrastructure and remove its
> dependence on MAX_ATP arrays?

Sure, i can do that.
