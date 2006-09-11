Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbWIKFYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWIKFYt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 01:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWIKFYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 01:24:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26579 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964828AbWIKFYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 01:24:48 -0400
Date: Mon, 11 Sep 2006 01:31:44 -0400
From: Dave Jones <davej@redhat.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: John Richard Moser <nigelenki@comcast.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Cache line size
Message-ID: <20060911053144.GB18727@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	John Richard Moser <nigelenki@comcast.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200609110100_MC3-1-CAD3-E525@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609110100_MC3-1-CAD3-E525@compuserve.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2006 at 12:58:43AM -0400, Chuck Ebbert wrote:
 > > Is there a way for the Linux Kernel to know the cache line size of the
 > > CPU it's on, besides #define X86_CACHE_LINE_SZ 32 or whatnot?
 > 
 > /sys/devices/system/cpu/cpu<N>/cache

Hmm..

$ find /sys/ -name cache
$

That's on 2.6.18rc6.  Is this some -mm only feature?

	Dave
