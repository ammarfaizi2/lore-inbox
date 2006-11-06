Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753733AbWKFXjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733AbWKFXjK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 18:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753929AbWKFXjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 18:39:10 -0500
Received: from verein.lst.de ([213.95.11.210]:13273 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1753728AbWKFXjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 18:39:07 -0500
Date: Tue, 7 Nov 2006 00:39:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] add dev_to_node()
Message-ID: <20061106233900.GA7148@lst.de>
References: <20061104225629.GA31437@lst.de> <20061104230648.GB640@redhat.com> <20061104235323.GA1353@lst.de> <20061105.002237.18309940.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061105.002237.18309940.davem@davemloft.net>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -0.6 () BAYES_01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2006 at 12:22:37AM -0800, David Miller wrote:
> Looks good to me.

So what's the right path to get this in?  There's one patch touching
MM code, one adding something to the driver core and then finally a
networking patch depending on the previous two.  Do you want to take
them all and send them in through the networking tree?  Or should
we put the burden on Andrew?
