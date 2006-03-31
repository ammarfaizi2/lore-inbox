Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbWCaO52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWCaO52 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 09:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWCaO52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 09:57:28 -0500
Received: from unthought.net ([212.97.129.88]:59661 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S1751381AbWCaO51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 09:57:27 -0500
Date: Fri, 31 Mar 2006 16:57:26 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org
Subject: Re: NFS client (10x) performance regression 2.6.14.7 -> 2.6.15
Message-ID: <20060331145726.GL9811@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	"Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	linux-kernel@vger.kernel.org
References: <20060331094850.GF9811@unthought.net> <1143807770.8096.4.camel@lade.trondhjem.org> <20060331124518.GH9811@unthought.net> <1143810392.8096.11.camel@lade.trondhjem.org> <20060331132131.GI9811@unthought.net> <1143812658.8096.18.camel@lade.trondhjem.org> <20060331140816.GJ9811@unthought.net> <1143814889.8096.22.camel@lade.trondhjem.org> <20060331143500.GK9811@unthought.net> <20060331144951.GA9207@ti64.telemetry-investments.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060331144951.GA9207@ti64.telemetry-investments.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2006 at 09:49:51AM -0500, Bill Rugolsky Jr. wrote:
...
> Jakob,
> 
> Your NFS setup is specific to your system. 

True. But it is my impression that this is a problem isolated on the
client side (am I wrong?)

> Have you considered trying this
> over loopback to narrow down the variables?

Do you mean NFS exporting a local filesystem, NFS mounting it again on
the local host?   Or do you mean something with loopback mounts?

(Sorry if that's a stupid question, but I just need to know what you
mean :)

> If you see similar getattr/write
> behavior over loopback, it will make it easy for everyone else to test.

True.

I've currently tried compiling the kernel with three different gcc
versions to see if that made any change. It didn't. And I tried SMP
versus UP, again no difference. I'm just about to try HIGHMEM vs no
HIGHMEM...

Thanks for your suggestion - I will try it, if you tell me precisely
what you mean in the above  :)

-- 

 / jakob

