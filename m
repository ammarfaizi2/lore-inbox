Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946518AbWJSV3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946518AbWJSV3H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 17:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946521AbWJSV3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 17:29:07 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:27071 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1946518AbWJSV3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 17:29:04 -0400
Date: Thu, 19 Oct 2006 14:28:56 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Will Schmidt <will_schmidt@vnet.ibm.com>
cc: Anton Blanchard <anton@samba.org>, akpm@osdl.org, linuxppc-dev@ozlabs.org,
       Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
In-Reply-To: <1161290229.8946.51.camel@farscape>
Message-ID: <Pine.LNX.4.64.0610191427270.10316@schroedinger.engr.sgi.com>
References: <1161026409.31903.15.camel@farscape> 
 <Pine.LNX.4.64.0610161221300.6908@schroedinger.engr.sgi.com> 
 <1161031821.31903.28.camel@farscape>  <Pine.LNX.4.64.0610161630430.8341@schroedinger.engr.sgi.com>
  <17717.50596.248553.816155@cargo.ozlabs.ibm.com> 
 <Pine.LNX.4.64.0610180811040.27096@schroedinger.engr.sgi.com> 
 <17718.39522.456361.987639@cargo.ozlabs.ibm.com> 
 <Pine.LNX.4.64.0610181448250.30710@schroedinger.engr.sgi.com> 
 <17719.1849.245776.4501@cargo.ozlabs.ibm.com> 
 <Pine.LNX.4.64.0610190906490.7852@schroedinger.engr.sgi.com> 
 <20061019163044.GB5819@krispykreme>  <Pine.LNX.4.64.0610190959560.8433@schroedinger.engr.sgi.com>
 <1161290229.8946.51.camel@farscape>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2006, Will Schmidt wrote:

> This didnt fix the problem on my box.  I tried this both against mm and
> linux-2.6.git 

Same failure condition? Would you also apply the printk patch and send 
me the output?
