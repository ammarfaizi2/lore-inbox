Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbVAXTT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVAXTT1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 14:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbVAXTTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 14:19:08 -0500
Received: from rproxy.gmail.com ([64.233.170.196]:19205 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261570AbVAXTRQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 14:17:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=pdMksaVmiJXf7XbnJTWadK38dSaqKESwi7+OdpaRpqDTEBmA8zxFM29FuY5DqX+9rsJycX66pysJeLFvSnJBcCwlYTCXH/a5gGMg1oEAmPhBFUFqrbL0Uh5Wud0lzFxLzWCe/k/l5KEw752vrRiX6UvshUNV9dtUznSl03Z4H34=
Message-ID: <9e473391050124111767a9c6b7@mail.gmail.com>
Date: Mon, 24 Jan 2005 14:17:15 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Matthew Wilcox <matthew@wil.cx>
Subject: Re: Fwd: Patch to control VGA bus routing and active VGA device.
Cc: Jesse Barnes <jbarnes@sgi.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050124175131.GM31455@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339105011719436a9e5038@mail.gmail.com>
	 <41ED3BD2.1090105@pobox.com>
	 <9e473391050122083822a7f81c@mail.gmail.com>
	 <200501240847.51208.jbarnes@sgi.com>
	 <20050124175131.GM31455@parcelfarce.linux.theplanet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005 17:51:31 +0000, Matthew Wilcox <matthew@wil.cx> wrote:
> Yes -- *very* platform specific.  Some are even configurable as to how
> much they support.  See http://ftp.parisc-linux.org/docs/chips/zx1-mio.pdf

Is this a justification for doing device drivers for bridge chips? It
has been mentioned before but no one has done it.

Any ideas why the code I sent won't work on the x86? I can shut
routing off but I can't get it back on again.

The motivation behind the code is to get X to quit doing this from user space.

-- 
Jon Smirl
jonsmirl@gmail.com
