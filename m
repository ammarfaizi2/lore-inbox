Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbVAHBWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbVAHBWI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 20:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVAHBWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 20:22:07 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:37816 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261733AbVAHBWF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 20:22:05 -0500
Subject: Re: [RFC] 2.4 and stack reduction patches
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1105137646.10979.155.camel@lade.trondhjem.org>
References: <1105112886.4000.87.camel@dyn318077bld.beaverton.ibm.com>
	 <20050107141224.GF29176@logos.cnet>
	 <1105134173.4000.105.camel@dyn318077bld.beaverton.ibm.com>
	 <1105137646.10979.155.camel@lade.trondhjem.org>
Content-Type: text/plain
Organization: 
Message-Id: <1105145706.4000.123.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Jan 2005 16:55:06 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-07 at 14:40, Trond Myklebust wrote:

> 
> You're better off using rpc_new_task() in rpc_call_sync(): no kfree()
> required, and no rpc_init_task() required.
> 

Hmm.. I am trying to do this. Just wanted to double check.

If I don't do kfree(), its gets automatically freed up thro
rpc_release_task() correct ?

Thanks,
Badari

