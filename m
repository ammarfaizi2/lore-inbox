Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbUBQHfb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 02:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbUBQHfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 02:35:31 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:8720 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261774AbUBQHf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 02:35:27 -0500
Date: Tue, 17 Feb 2004 07:35:22 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Non-GPL export of invalidate_mmap_range
Message-ID: <20040217073522.A25921@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Paul E. McKenney" <paulmck@us.ibm.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20040216190927.GA2969@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040216190927.GA2969@us.ibm.com>; from paulmck@us.ibm.com on Mon, Feb 16, 2004 at 11:09:27AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 16, 2004 at 11:09:27AM -0800, Paul E. McKenney wrote:
> Hello, Andrew,
> 
> The attached patch to make invalidate_mmap_range() non-GPL exported
> seems to have been lost somewhere between 2.6.1-mm4 and 2.6.1-mm5.
> It still applies cleanly.  Could you please take it up again?

And there's still no reason to ease IBM's GPL violations by exporting
deep VM internals.  The GPLed DFS you claimed you needed this for still
hasn't shown up but instead you want to change the export all the time.

Tells a lot about IBMs promises..

