Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVAGDlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVAGDlt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 22:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVAGDls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 22:41:48 -0500
Received: from holomorphy.com ([207.189.100.168]:49092 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261178AbVAGDlr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 22:41:47 -0500
Date: Thu, 6 Jan 2005 19:41:45 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: torvalds@osdl.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Make pipe data structure be a circular list of pages, rather than
Message-ID: <20050107034145.GI9636@holomorphy.com>
References: <200501070313.j073DCaQ009641@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501070313.j073DCaQ009641@hera.kernel.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 12:29:13AM +0000, Linux Kernel Mailing List wrote:
> ChangeSet 1.2229.1.1, 2005/01/06 16:29:13-08:00, torvalds@ppc970.osdl.org
> 	Make pipe data structure be a circular list of pages, rather than
> 	a circular list of one page.
> 	This improves pipe throughput, and allows us to (eventually)
> 	use these lists of page buffers for moving data around efficiently.

Interesting; how big a gain did you see?


-- wli
