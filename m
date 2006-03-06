Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752408AbWCFTyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408AbWCFTyr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 14:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752413AbWCFTyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 14:54:47 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:61310 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750926AbWCFTyq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 14:54:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sgBObPj52f8M+Vrjua6LnHtgexIIJRvuQvWJcBvpTM4eGjy4fAksLjHgWgN5d94h6fvTjjoEiV2jiUEtsX0/BhJZ2+FLko+S0rv93x1/1TZyxJy9D9cI/QjHlrLPD9wv71pTvOET3JJyQwrIMxSMM0NNlR0vUO/70ng2LFjRlG0=
Message-ID: <eada2a070603061154p3528a099if5e640d6da2ca9e1@mail.gmail.com>
Date: Mon, 6 Mar 2006 11:54:45 -0800
From: "Tim Pepper" <lnxninja@us.ibm.com>
To: pbadari@us.ibm.com
Subject: Re: [PATCH 1/4] change buffer_head.b_size to size_t
Cc: "Andrew Morton" <akpm@osdl.org>, "Nathan Scott" <nathans@sgi.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060301185616.69986425.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1141075239.10542.19.camel@dyn9047017100.beaverton.ibm.com>
	 <1141075361.10542.21.camel@dyn9047017100.beaverton.ibm.com>
	 <20060301175148.2250b36e.akpm@osdl.org>
	 <20060302132232.C88229@wobbly.melbourne.sgi.com>
	 <20060301185616.69986425.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you're looking for nice wording: I forget if it is Linux Device
Drivers, Understanding the Linux Kernel or Linux Kernel Development,
but more or less combined they manage to describe the bastard state of
what struct buffer_head used to be and how bio coming along leaves bh
primarily as mapping between a memory buffer and a disk block.  With
block related things being abstracted cleaner as of 2.6 (and that
hopefully being a continuing goal) I'd vote for any change to this
struct's comment focusing on what the struct is meant to do, not what
abstractions have been (ab)used to accomplish different things over
time.


Tim
