Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVCaIPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVCaIPs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 03:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVCaIPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 03:15:48 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:5564 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261164AbVCaIPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 03:15:43 -0500
Date: Thu, 31 Mar 2005 00:15:13 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: hancockr@shaw.ca, linux-kernel@vger.kernel.org
Subject: Re: AMD64 Machine hardlocks when using memset
Message-Id: <20050331001513.3c4321a7.pj@engr.sgi.com>
In-Reply-To: <200503311025.56871.vda@ilport.com.ua>
References: <3NTHD-8ih-1@gated-at.bofh.it>
	<424B7ECD.6040905@shaw.ca>
	<200503311025.56871.vda@ilport.com.ua>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis wrote:
> This reminds me on VIA northbridge problem when BIOS enabled
> a feature which was experimental and turned out to be buggy.

You were close!

I changed my Memory Timing from 1T to 2T, and now it is as solid as a
rock.  It has been up 7 minutes as I type this, without a hiccup.

Notice this comment, at http://www.vr-zone.com.sg/?i=1641&p=1&s=0

    Well as most Athlon 64 users know, 1T setting improves performance quite
    significantly over 2T, but it is also very taxing on the memory and
    quite a hit-and-miss when matching different memory with different
    boards. From some users' feedback, the Asus A8N SLI can be a little
    picky with 1T setting when overclocking, so results might be a little
    better with other boards.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
