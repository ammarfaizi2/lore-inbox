Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262752AbUDAH3d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 02:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbUDAH3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 02:29:33 -0500
Received: from mail.kroah.org ([65.200.24.183]:43473 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262752AbUDAH1A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 02:27:00 -0500
Date: Wed, 31 Mar 2004 23:15:09 -0800
From: Greg KH <greg@kroah.com>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, torvalds@osdl.org,
       david-b@pacbell.net, viro@math.psu.edu,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [PATCH] back out sysfs reference count change
Message-ID: <20040401071509.GB13028@kroah.com>
References: <20040331092631.GA21484@in.ibm.com> <Pine.LNX.4.44L0.0403311001440.1752-100000@ida.rowland.org> <20040401051740.GA1291@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040401051740.GA1291@in.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 10:47:40AM +0530, Maneesh Soni wrote:
> I am out of any more ideas except something like making sysfs single threaded 
> or requesting people to try my sysfs backing store patch set. It does not
> suffer from the negative dentries problem as it does not create any negative
> dentries. I have to re-diff the patch set again to take recent changes into
> account.

Hm, well that is the best reason so far that I have heard to accept your
patch set.

So let's revisit this after Al audits the patches, ok?

thanks,

greg k-h
