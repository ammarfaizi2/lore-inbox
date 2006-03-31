Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWCaPEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWCaPEz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 10:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWCaPEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 10:04:55 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:62125 "EHLO
	mail1.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S932108AbWCaPEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 10:04:54 -0500
Date: Fri, 31 Mar 2006 10:04:53 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Jakob Oestergaard <jakob@unthought.net>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org
Subject: Re: NFS client (10x) performance regression 2.6.14.7 -> 2.6.15
Message-ID: <20060331150453.GB9207@ti64.telemetry-investments.com>
Reply-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Jakob Oestergaard <jakob@unthought.net>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	linux-kernel@vger.kernel.org
References: <1143807770.8096.4.camel@lade.trondhjem.org> <20060331124518.GH9811@unthought.net> <1143810392.8096.11.camel@lade.trondhjem.org> <20060331132131.GI9811@unthought.net> <1143812658.8096.18.camel@lade.trondhjem.org> <20060331140816.GJ9811@unthought.net> <1143814889.8096.22.camel@lade.trondhjem.org> <20060331143500.GK9811@unthought.net> <20060331144951.GA9207@ti64.telemetry-investments.com> <20060331145726.GL9811@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060331145726.GL9811@unthought.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2006 at 04:57:26PM +0200, Jakob Oestergaard wrote:
> True. But it is my impression that this is a problem isolated on the
> client side (am I wrong?)

That seems to be the case.

> Do you mean NFS exporting a local filesystem, NFS mounting it again on
> the local host?   Or do you mean something with loopback mounts?
 
The former; just export a local directory to 127.0.0.1 in /etc/exports,
then mount it on /mnt.

> Thanks for your suggestion - I will try it, if you tell me precisely
> what you mean in the above  :)

I'll give it a try here.

	-Bill
