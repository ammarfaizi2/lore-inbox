Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265929AbTIKAvx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 20:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265930AbTIKAvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 20:51:53 -0400
Received: from holomorphy.com ([66.224.33.161]:56757 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265929AbTIKAvw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 20:51:52 -0400
Date: Wed, 10 Sep 2003 17:52:53 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jesse Barnes <jbarnes@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] you have how many nodes??
Message-ID: <20030911005253.GO4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, Jesse Barnes <jbarnes@sgi.com>,
	linux-kernel@vger.kernel.org
References: <20030910213602.GC17266@sgi.com> <20030910151254.52f53e62.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910151254.52f53e62.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 03:12:54PM -0700, Andrew Morton wrote:
> Instead of going backwards like this we'd like to actually free up _more_
> bits in page->flags.  The worst (and controlling) case is on 32-bit NUMA:
> eight nodes, three zones per node.  That's five bits, leaving us 27 page
> flags.

The worst case for i386 NUMA is actually 16 nodes.


-- wli
