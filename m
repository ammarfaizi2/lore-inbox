Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbTKYNme (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 08:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbTKYNme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 08:42:34 -0500
Received: from holomorphy.com ([199.26.172.102]:4027 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262679AbTKYNmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 08:42:33 -0500
Date: Tue, 25 Nov 2003 05:42:22 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jes Sorensen <jes@trained-monkey.org>
Cc: Alexander Viro <viro@math.psu.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, jbarnes@sgi.com, steiner@sgi.com
Subject: Re: hash table sizes
Message-ID: <20031125134222.GA8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jes Sorensen <jes@trained-monkey.org>,
	Alexander Viro <viro@math.psu.edu>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, jbarnes@sgi.com, steiner@sgi.com
References: <16323.23221.835676.999857@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16323.23221.835676.999857@gargle.gargle.HOWL>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 25, 2003 at 08:35:49AM -0500, Jes Sorensen wrote:
> +	mempages >>= (23 - (PAGE_SHIFT - 1));
> +	order = max(2, fls(mempages));
> +	order = min(12, order);

This is curious; what's 23 - (PAGE_SHIFT - 1) supposed to represent?


-- wli
