Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVDNAM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVDNAM0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 20:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVDNAL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 20:11:28 -0400
Received: from waste.org ([216.27.176.166]:48031 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261242AbVDNAKi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 20:10:38 -0400
Date: Wed, 13 Apr 2005 17:09:39 -0700
From: Matt Mackall <mpm@selenic.com>
To: Jean-Luc Cooke <jlcooke@certainkey.com>
Cc: linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au
Subject: Re: Fortuna
Message-ID: <20050414000939.GH3174@waste.org>
References: <20050413234337.GE12263@certainkey.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050413234337.GE12263@certainkey.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 07:43:37PM -0400, Jean-Luc Cooke wrote:
> Ahh.  Thanks Herbert.
> 
> Matt,
> 
> Any insight on how to test syn cookies and the other network stuff in
> random.c?  My patch is attached, but I havn't tested that part yet.

For starters, this is not against anything like a current random.c. A
great number of cleanups have been done.

Syncookies are perhaps best tested with printk of the cookie
ingredients in the generation and check steps.

-- 
Mathematics is the supreme nostalgia of our time.
