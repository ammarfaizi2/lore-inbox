Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261896AbVCNVCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbVCNVCA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 16:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbVCNVCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 16:02:00 -0500
Received: from waste.org ([216.27.176.166]:20920 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261896AbVCNVB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 16:01:59 -0500
Date: Mon, 14 Mar 2005 13:01:58 -0800
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] "PREEMPT" in UTS_VERSION
Message-ID: <20050314210158.GG32638@waste.org>
References: <20050209184011.GB2366@waste.org> <20050314204917.GB17925@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050314204917.GB17925@mars.ravnborg.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 09:49:17PM +0100, Sam Ravnborg wrote:
> On Wed, Feb 09, 2005 at 10:40:11AM -0800, Matt Mackall wrote:
> > Add PREEMPT to UTS_VERSION where enabled as is done for SMP to make
> > preempt kernels easily identifiable.
> I have the following patch in my tree now. It has the advantage that
> compile.h gets updated when you change the PREEMPT setting.
> 
> How many scripts parsing the output of `uname -v` will break because of
> this?

None that wouldn't have already broken from free-form extraversion and
vendor version crap, I suspect.

-- 
Mathematics is the supreme nostalgia of our time.
