Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268535AbUI3ApA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268535AbUI3ApA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 20:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269237AbUI3ApA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 20:45:00 -0400
Received: from holomorphy.com ([207.189.100.168]:24985 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268535AbUI3Ao6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 20:44:58 -0400
Date: Wed, 29 Sep 2004 17:44:47 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Judith Lebzelter <judith@osdl.org>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: OSDL aio-stress results on latest kernels show buffered random read issue
Message-ID: <20040930004447.GI9106@holomorphy.com>
References: <Pine.LNX.4.33.0409291621170.4332-100000@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0409291621170.4332-100000@osdlab.pdx.osdl.net>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 04:29:08PM -0700, Judith Lebzelter wrote:
> There seems to be an issue with the reads.  Usually, reads
> should be at least as fast as writes of the same type.
> Also, there seems to be a substantial drop-off in the performance
> of AIO buffered-random writes in the mm kernels. (14% on 2CPU,
> 40% on 4CPU)

Okay, is it cpu time or idle/iowait? If it's cpu time, where do
profiles show it appears?


-- wli
