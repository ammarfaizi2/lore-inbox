Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266319AbUBJTE2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 14:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266324AbUBJTE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 14:04:28 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:37646 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266319AbUBJTE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 14:04:27 -0500
Date: Tue, 10 Feb 2004 19:04:13 +0000
From: Christoph Hellwig <hch@infradead.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Greg KH <greg@kroah.com>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Newest fbdev patch to go mainline.
Message-ID: <20040210190413.A8470@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Simmons <jsimmons@infradead.org>, Greg KH <greg@kroah.com>,
	Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040210173551.GC27779@kroah.com> <Pine.LNX.4.44.0402101747450.6600-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0402101747450.6600-100000@phoenix.infradead.org>; from jsimmons@infradead.org on Tue, Feb 10, 2004 at 05:49:52PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 05:49:52PM +0000, James Simmons wrote:
> Thats coming :-) The problem only showes itself with modular drivers 
> correct. So I will submit patches for those first. I just wanted to polish 
> off a few really tiny patches fist.

You just copletly b0rked up lifetime rules.  Please revert the sysfs patch
and add it back when all drivers are fixed.  

