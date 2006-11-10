Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161912AbWKJSQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161912AbWKJSQx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 13:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161924AbWKJSQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 13:16:53 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:42171 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161912AbWKJSQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 13:16:52 -0500
Date: Fri, 10 Nov 2006 10:16:35 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: Christoph Hellwig <hch@lst.de>, davem@davemloft.net,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] add dev_to_node()
In-Reply-To: <20061108114038.59831f9d.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.64.0611101015060.25338@schroedinger.engr.sgi.com>
References: <20061030141501.GC7164@lst.de> <20061030.143357.130208425.davem@davemloft.net>
 <20061104225629.GA31437@lst.de> <20061108114038.59831f9d.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2006, KAMEZAWA Hiroyuki wrote:

> I wonder there are no code for creating NODE_DATA() for device-only-node.

On IA64 we remap nodes with no memory / cpus to the nearest node with 
memory. I think that is sufficient.


