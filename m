Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267214AbUHSSgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267214AbUHSSgi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 14:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267219AbUHSSgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 14:36:37 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:33287 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267214AbUHSSgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 14:36:33 -0400
Date: Thu, 19 Aug 2004 19:36:31 +0100
From: Christoph Hellwig <hch@infradead.org>
To: jmerkey@comcast.net
Cc: linux-kernel@vger.kernel.org, jmerkey@drdos.com
Subject: Re: 2.6.8 kmem_cache_alloc barfs
Message-ID: <20040819193631.A12192@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	jmerkey@comcast.net, linux-kernel@vger.kernel.org,
	jmerkey@drdos.com
References: <081920041818.4794.4124EEEB0009B419000012BA2200748184970A059D0A0306@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <081920041818.4794.4124EEEB0009B419000012BA2200748184970A059D0A0306@comcast.net>; from jmerkey@comcast.net on Thu, Aug 19, 2004 at 06:18:20PM +0000
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 06:18:20PM +0000, jmerkey@comcast.net wrote:
> 
> in 2.6.8 with all features and config options (at least those that will build) with 4GB memory option selected, kmem_cache_alloc crashes when called with requests for 64KB chunks of memory which exceed the kernel address space of 1GB in size rather than returning an out of memory error.  

testcase please.

