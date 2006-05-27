Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbWE0HVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbWE0HVy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 03:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbWE0HVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 03:21:53 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:60032 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751435AbWE0HVx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 03:21:53 -0400
Message-ID: <348714509.13853@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Sat, 27 May 2006 15:22:01 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/33] readahead: state based method - aging accounting
Message-ID: <20060527072201.GA5284@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060524111246.420010595@localhost.localdomain> <348469542.24469@ustc.edu.cn> <20060526100426.2faf1367.akpm@osdl.org> <348710943.27498@ustc.edu.cn> <20060527000058.70e84318.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060527000058.70e84318.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 27, 2006 at 12:00:58AM -0700, Andrew Morton wrote:
> Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
> >
> > > Is this function well-named?  Why does it have "cold" in the name?
> > 
> >  Because it only sums `nr_inactive', leaving out `nr_active'.
> 
> We use the term "cold" to refer to probably-cache-cold pages in the page
> allocator.  How about you use "inactive"?

Got it, thanks.
