Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbTHTVQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 17:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbTHTVQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 17:16:27 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:15628 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262215AbTHTVQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 17:16:27 -0400
Date: Wed, 20 Aug 2003 22:16:13 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Greg KH <greg@kroah.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [RFC] add class/video to fb drivers - Take 2
In-Reply-To: <20030820191001.GA4185@kroah.com>
Message-ID: <Pine.LNX.4.44.0308202044280.9662-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ok, here's a smaller version of the patch, that doesn't break any fb
> drivers.  Only those that have a struct device associated with them
> should be changed (and that's just a 1 line addition).  I think it's
> much better because of this.

Nice :-) Will apply tonight. Do you have any issues still with this 
approach. You talked about the issue of dynamically creating the data. Is 
this probnlem still present in this patch.



