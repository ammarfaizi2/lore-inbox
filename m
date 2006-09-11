Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWIKFDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWIKFDf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 01:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbWIKFDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 01:03:35 -0400
Received: from liaag1ae.mx.compuserve.com ([149.174.40.31]:6596 "EHLO
	liaag1ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S964778AbWIKFDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 01:03:34 -0400
Date: Mon, 11 Sep 2006 00:58:43 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Cache line size
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200609110100_MC3-1-CAD3-E525@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <4504AF26.9040807@comcast.net>

On Sun, 10 Sep 2006 20:34:46 -0400, John Richard Moser wrote:

> Is there a way for the Linux Kernel to know the cache line size of the
> CPU it's on, besides #define X86_CACHE_LINE_SZ 32 or whatnot?
> 

/sys/devices/system/cpu/cpu<N>/cache

-- 
Chuck

