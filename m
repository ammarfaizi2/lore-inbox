Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754794AbWKITGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754794AbWKITGV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 14:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754797AbWKITGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 14:06:21 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:5317 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1754794AbWKITGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 14:06:20 -0500
Date: Thu, 9 Nov 2006 11:05:26 -0800
From: Paul Jackson <pj@sgi.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       xemul@openvz.org, devel@openvz.org, oleg@tv-sign.ru, hch@infradead.org,
       matthltc@us.ibm.com, ckrm-tech@lists.sourceforge.net
Subject: Re: [PATCH 6/13] BC: kmemsize accounting (core)
Message-Id: <20061109110526.7644479f.pj@sgi.com>
In-Reply-To: <45535EA3.10300@sw.ru>
References: <45535C18.4040000@sw.ru>
	<45535EA3.10300@sw.ru>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define __GFP_BC	 ((__force gfp_t)0x80000u) /* Charge allocation with BC */

Please include the term "beancounter" in that comment.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
