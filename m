Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267773AbUHSAuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267773AbUHSAuk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 20:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267777AbUHSAuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 20:50:40 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:38019 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267773AbUHSAui (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 20:50:38 -0400
Date: Wed, 18 Aug 2004 17:50:03 -0700
From: Paul Jackson <pj@sgi.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [samuel.thibault@ens-lyon.org: Re: warning: comparison is
 always false due to limited range of  data type]
Message-Id: <20040818175003.1d1671bb.pj@sgi.com>
In-Reply-To: <20040818230211.GG22559@bouh.is-a-geek.org>
References: <20040818230211.GG22559@bouh.is-a-geek.org>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel wrote:
> Here is another approach. This should never warning, and should get
> optimized away as needed.

Yours looks like it has a better chance of not being broken by some
future gcc enhancement that can see through the obfuscation in mine.

I didn't actually try it, but yours looks good to me.

Thanks.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
