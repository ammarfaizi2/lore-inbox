Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751809AbWHATLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbWHATLJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 15:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbWHATLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 15:11:09 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:29869 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751809AbWHATLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 15:11:07 -0400
Date: Tue, 1 Aug 2006 12:10:45 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Andrew Morton <akpm@osdl.org>, Herbert Xu <herbert@gondor.apana.org.au>,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [BLOCK] bh: Ensure bh fits within a page
In-Reply-To: <1154459316.29772.5.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0608011209560.18537@schroedinger.engr.sgi.com>
References: <20060801030443.GA2221@gondor.apana.org.au> 
 <20060731210418.084f9f5d.akpm@osdl.org>  <20060801050259.GA3126@gondor.apana.org.au>
  <20060731225454.19981a5f.akpm@osdl.org>  <Pine.LNX.4.64.0608011034540.18006@schroedinger.engr.sgi.com>
 <1154459316.29772.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2006, Steven Rostedt wrote:

> If you set the alignment for ext3 the same as the size (ie 1024, 2048,
> 4096 for the above respectively) then wouldn't that guarantee not
> straddling a page?

Yes. But then that number must always be a fraction of pagesize.


