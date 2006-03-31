Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbWCaOt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbWCaOt6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 09:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWCaOt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 09:49:57 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:32173 "EHLO
	mail1.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S1751372AbWCaOt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 09:49:57 -0500
Date: Fri, 31 Mar 2006 09:49:51 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Jakob Oestergaard <jakob@unthought.net>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org
Subject: Re: NFS client (10x) performance regression 2.6.14.7 -> 2.6.15
Message-ID: <20060331144951.GA9207@ti64.telemetry-investments.com>
Reply-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Jakob Oestergaard <jakob@unthought.net>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	linux-kernel@vger.kernel.org
References: <20060331094850.GF9811@unthought.net> <1143807770.8096.4.camel@lade.trondhjem.org> <20060331124518.GH9811@unthought.net> <1143810392.8096.11.camel@lade.trondhjem.org> <20060331132131.GI9811@unthought.net> <1143812658.8096.18.camel@lade.trondhjem.org> <20060331140816.GJ9811@unthought.net> <1143814889.8096.22.camel@lade.trondhjem.org> <20060331143500.GK9811@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060331143500.GK9811@unthought.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2006 at 04:35:00PM +0200, Jakob Oestergaard wrote:
> I'm wondering... Can anyone else reproduce this problem?
> 
> Just to explain quickly:
>  Running nfsbench (on the NFS client) once with LEADING_EMPTY_SPACE set
>  to 0 and then once with the option set to 1.  If there's a big change
>  in wall-clock execution time, this indicates that the problem exists.
> 
> I'd be really interested in knowing whether I'm the only one who sees
> this problem.
 
Jakob,

Your NFS setup is specific to your system.  Have you considered trying this
over loopback to narrow down the variables?  If you see similar getattr/write
behavior over loopback, it will make it easy for everyone else to test.

	-Bill
