Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264599AbTLMNWO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 08:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264931AbTLMNWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 08:22:14 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:35346 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S264599AbTLMNWN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 08:22:13 -0500
Date: Sat, 13 Dec 2003 14:22:08 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Wakko Warner <wakko@animx.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 and IDE "geometry"
Message-ID: <20031213132208.GA11523@win.tue.nl>
References: <20031212131704.A26577@animx.eu.org> <20031212194439.GB11215@win.tue.nl> <20031212163545.A26866@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031212163545.A26866@animx.eu.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 04:35:45PM -0500, Wakko Warner wrote:

> > The kernel does not use any geometry.
> 
> This I know, however, the kernel in the past has the geometry from the BIOS

The kernel made some attempts. It often worked and often failed.

> > So your real question is:
> > "Is there a way to get *fdisk to use my favorite geometry?"
> > The answer is: all common fdisk versions allow you to set the geometry.
> 
> I realize this too, however, I need it to happen automatically and be
> consistent with the bios idea of the disk.

So you script sfdisk or so in order to setup large numbers of disks
and cannot use constant geometry settings because this is on many
different BIOSes that disagree on the desired geometry?

And this is all on disks smaller than 8 GB so that at least there can be
some geometry?

