Return-Path: <linux-kernel-owner+willy=40w.ods.org-S282159AbUKBDmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S282159AbUKBDmN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 22:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S282151AbUKBDmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 22:42:10 -0500
Received: from holomorphy.com ([207.189.100.168]:62604 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S273454AbUKBDlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 22:41:51 -0500
Date: Mon, 1 Nov 2004 19:41:40 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: PG_zero
Message-ID: <20041102034140.GS2583@holomorphy.com>
References: <20041030141059.GA16861@dualathlon.random> <20041030140732.2ccc7d22.akpm@osdl.org> <20041030224528.GB3571@dualathlon.random> <43630000.1099236900@[10.10.2.4]> <20041101215709.GD3571@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041101215709.GD3571@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2004 at 10:57:09PM +0100, Andrea Arcangeli wrote:
> However the real point of the patch is to address all other issues with
> the per-cpu list and to fixup the lack of pte_quicklist in 2.6, and to
> avoid wasting zeropages (like the pte_quicklists did) by sharing them
> with all other page-zero users.

For the record, I had pte prezeroing patches written and posted prior
to 2.6.0, and had maintained them for a year when I gave up on them.


-- wli
