Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVBWAOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVBWAOn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 19:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVBWAOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 19:14:43 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:37298 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261348AbVBWAOl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 19:14:41 -0500
Date: Tue, 22 Feb 2005 16:14:12 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: mingo@elte.hu, raybry@sgi.com, mort@wildopensource.com,
       linux-kernel@vger.kernel.org, hilgeman@sgi.com
Subject: Re: [PATCH/RFC] A method for clearing out page cache
Message-Id: <20050222161412.4699fef6.pj@sgi.com>
In-Reply-To: <20050222104535.0b3a3c65.akpm@osdl.org>
References: <20050214154431.GS26705@localhost>
	<20050214193704.00d47c9f.pj@sgi.com>
	<20050221192721.GB26705@localhost>
	<20050221134220.2f5911c9.akpm@osdl.org>
	<421A607B.4050606@sgi.com>
	<20050221144108.40eba4d9.akpm@osdl.org>
	<20050222075304.GA778@elte.hu>
	<20050222032633.5cb38abb.pj@sgi.com>
	<20050222104535.0b3a3c65.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew asked:
> So...  Cannot the applicaiton remove all its pagecache with posix_fadvise()
> prior to exitting?

Hang on ...

The replies of Ray and Martin answer your immediate question.

But we (SGI) are still busy discussing the bigger picture behind the
scenes ...

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
