Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262810AbUDYDQC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbUDYDQC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 23:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbUDYDQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 23:16:02 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:15627 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262810AbUDYDQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 23:16:00 -0400
Date: Sun, 25 Apr 2004 04:15:57 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Jason Cox <steel300@gentoo.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Change number of tty devices
In-Reply-To: <20040422093302.B19797@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0404250414330.15965-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Thu, Apr 22, 2004 at 02:24:06AM +0000, Jason Cox wrote:
> > > When the kernel supports multi-desktop systems we will have to deal
> > > with the serial and VT issue. Most likely the serial tty drivers will
> > > be given a different major number. 
> > 
> > Why isn't this done now?
> 
> It's a API change and requires a flag day "everyone update their
> filesystem."  Especially in a stable kernel series.

By the time 2.7.X comes around everyone should be using udev. That should 
settle any problems. 

