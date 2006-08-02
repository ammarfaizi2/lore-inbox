Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbWHBHqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWHBHqd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 03:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWHBHqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 03:46:32 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:42885 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751357AbWHBHq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 03:46:29 -0400
Date: Wed, 2 Aug 2006 11:46:07 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: David Miller <davem@davemloft.net>
Cc: zach.brown@oracle.com, linux-kernel@vger.kernel.org, drepper@redhat.com,
       netdev@vger.kernel.org
Subject: Re: [take2 1/4] kevent: core files.
Message-ID: <20060802074606.GA15289@2ka.mipt.ru>
References: <11544248451203@2ka.mipt.ru> <44CFEA4B.3060200@oracle.com> <20060802063918.GB6378@2ka.mipt.ru> <20060802.002505.34764840.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060802.002505.34764840.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 02 Aug 2006 11:46:13 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 12:25:05AM -0700, David Miller (davem@davemloft.net) wrote:
> From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> Date: Wed, 2 Aug 2006 10:39:18 +0400
> 
> > u64 is not aligned, so I prefer to use u32 as much as possible.
> 
> We have aligned_u64 exactly for this purpose, netfilter makes
> use of it to avoid the x86_64 vs. x86 u64 alignment discrepency.

Ok, I will use that type.

-- 
	Evgeniy Polyakov
