Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261995AbUBWSpd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 13:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbUBWSpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 13:45:33 -0500
Received: from verein.lst.de ([212.34.189.10]:42452 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261995AbUBWSpc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 13:45:32 -0500
Date: Mon, 23 Feb 2004 19:45:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "David S. Miller" <davem@redhat.com>, Christoph Hellwig <hch@lst.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Please back out the bluetooth sysfs support
Message-ID: <20040223184525.GA12656@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Marcel Holtmann <marcel@holtmann.org>,
	"David S. Miller" <davem@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040223103613.GA5865@lst.de> <20040223101231.71be5da2.davem@redhat.com> <1077560544.2791.63.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077560544.2791.63.camel@pegasus>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 07:22:24PM +0100, Marcel Holtmann wrote:
> Hi Dave,
> 
> > Ok Christoph, I'm taking to Marcel about what we'll do, and thus
> > it'll be resolved within the next day one way or another.
> > 
> > Thanks for pointing this out.
> 
> it seems that I missed a posting here. What is the problem?

You converted bluetooth to the driver model completely ignoring the
sysfs-imposed lifetime rules.

p.s. my original mail went to linux & you, cc lkml so it should be
somewhere deep in your inbox
