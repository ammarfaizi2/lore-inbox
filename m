Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWCaSwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWCaSwv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 13:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWCaSwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 13:52:50 -0500
Received: from unthought.net ([212.97.129.88]:2578 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S1751129AbWCaSwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 13:52:50 -0500
Date: Fri, 31 Mar 2006 20:52:49 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org
Subject: Re: NFS client (10x) performance regression 2.6.14.7 -> 2.6.15
Message-ID: <20060331185249.GP9811@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	"Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	linux-kernel@vger.kernel.org
References: <20060331132131.GI9811@unthought.net> <1143812658.8096.18.camel@lade.trondhjem.org> <20060331140816.GJ9811@unthought.net> <1143814889.8096.22.camel@lade.trondhjem.org> <20060331143500.GK9811@unthought.net> <20060331144951.GA9207@ti64.telemetry-investments.com> <20060331145726.GL9811@unthought.net> <20060331150453.GB9207@ti64.telemetry-investments.com> <20060331152401.GM9811@unthought.net> <20060331163542.GC9207@ti64.telemetry-investments.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060331163542.GC9207@ti64.telemetry-investments.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2006 at 11:35:42AM -0500, Bill Rugolsky Jr. wrote:
...
> I don't see any problem over loopback either.  Perhaps I'll try increasing
> delays with tc netem.  That will have to wait until later.

That would be my next try.

> In any case, I tried on our NetApp FAS-250, and I see the same problem:
> Mount options are:
> netapp:/home /nfs/netapp/home nfs rw,v3,rsize=32768,wsize=32768,hard,intr,tcp,lock,addr=netapp 0 0

Thanks a lot!  Ah, I thought the computers only hated me  ;)

-- 

 / jakob

