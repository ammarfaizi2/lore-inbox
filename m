Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbTL2K7Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 05:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263002AbTL2K7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 05:59:25 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:20732 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S262913AbTL2K7Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 05:59:24 -0500
Date: Mon, 29 Dec 2003 02:59:18 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Page Colouring (was: 2.6.0 Huge pages not working as expected)
Message-ID: <20031229105918.GH1882@matchmail.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0312272046400.2274@home.osdl.org> <20031228163952.GQ22443@holomorphy.com> <20031229003631.GE1882@matchmail.com> <20031229025507.GT22443@holomorphy.com> <Pine.LNX.4.58.0312282000390.11299@home.osdl.org> <20031229065240.GU22443@holomorphy.com> <Pine.LNX.4.58.0312290112450.11299@home.osdl.org> <20031229092203.GL27687@holomorphy.com> <Pine.LNX.4.58.0312290129510.11299@home.osdl.org> <20031229102319.GW22443@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031229102319.GW22443@holomorphy.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 29, 2003 at 02:23:19AM -0800, William Lee Irwin III wrote:
> bits are sprinkled around, along with a few more involved changes because
> a large number of distributed changes are required to handle oddities
> that occur when PAGE_SIZE changes from 4KB. The more involved changes
> are often for things such as the only reason it uses PAGE_SIZE is
> really that it just expects 4KB and says PAGE_SIZE, or that it wants
> some fixed (even across compiles) size and needs updating for more
> general PAGE_SIZE numbers, or sometimes that it expects PAGE_SIZE to be
> what a pte maps when this is now represented by MMUPAGE_SIZE.

Any chance some of these changes are self contained, and could be split out
and possibly merged into -mm?
