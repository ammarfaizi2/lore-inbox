Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422725AbWAMQVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422725AbWAMQVV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 11:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422727AbWAMQVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 11:21:20 -0500
Received: from mx.pathscale.com ([64.160.42.68]:41937 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1422725AbWAMQVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 11:21:20 -0500
Subject: Re: [PATCH 2 of 3] memcpy32 for x86_64
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Chris Wedgwood <cw@f00f.org>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       hch@infradead.org, ak@suse.de, rdreier@cisco.com
In-Reply-To: <200601131224.36545.vda@ilport.com.ua>
References: <b4863171295fdb6e8206.1136922838@serpentine.internal.keyresearch.com>
	 <1137081882.28011.1.camel@serpentine.pathscale.com>
	 <20060113095625.GA3707@taniwha.stupidest.org>
	 <200601131224.36545.vda@ilport.com.ua>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Fri, 13 Jan 2006 08:21:09 -0800
Message-Id: <1137169269.29209.0.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-13 at 12:24 +0200, Denis Vlasenko wrote:

> you need just
> 
> 	.globl memcpy32
> memcpy32:
> 	movl %edx,%ecx
> 	rep movsd
> 	ret

This is what the current version of the patches in -mm does.

	<b

