Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263149AbUCSXoj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 18:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbUCSXoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 18:44:39 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:29940 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263149AbUCSXod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 18:44:33 -0500
Date: Fri, 19 Mar 2004 15:42:31 -0800
From: Paul Jackson <pj@sgi.com>
To: colpatch@us.ibm.com
Cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
       wli@holomorphy.com, haveblue@us.ibm.com, hch@infradead.org
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
Message-Id: <20040319154231.114bcfbf.pj@sgi.com>
In-Reply-To: <1079736707.17841.29.camel@arrakis>
References: <1079651064.8149.158.camel@arrakis>
	<20040318165957.592e49d3.pj@sgi.com>
	<1079659184.8149.355.camel@arrakis>
	<20040318174540.700917ea.pj@sgi.com>
	<1079736707.17841.29.camel@arrakis>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, if we're going to make a generic bitmap type, it shouldn't have
> size limitations, as almost any limit we set will be too small
> eventually... 

A trillion bits ...

Nah - bitmasks are a bunch of bits, layed out in order.  This is
appropriate for tens, hundreds, even (on big iron) thousands of
bits.

There are limitations to the practical application of such bitmasks,
as I'm sure we both agree and both accept.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
