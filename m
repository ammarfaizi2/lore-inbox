Return-Path: <linux-kernel-owner+w=401wt.eu-S1161133AbXALWMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161133AbXALWMD (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 17:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161136AbXALWMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 17:12:01 -0500
Received: from smtp.osdl.org ([65.172.181.24]:38684 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161135AbXALWMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 17:12:00 -0500
Date: Fri, 12 Jan 2007 14:11:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Paul Jackson <pj@sgi.com>, sander@humilis.net,
       linux-kernel@vger.kernel.org
Subject: Re: 'struct task_struct' has no member named 'mems_allowed'  (was:
 Re: 2.6.20-rc4-mm1)
Message-Id: <20070112141141.d9a73e32.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701121359290.3087@schroedinger.engr.sgi.com>
References: <20070111222627.66bb75ab.akpm@osdl.org>
	<20070112105224.GA12813@favonius>
	<20070112032820.9c995718.pj@sgi.com>
	<Pine.LNX.4.64.0701121123410.2296@schroedinger.engr.sgi.com>
	<20070112132016.f11ffc8a.pj@sgi.com>
	<Pine.LNX.4.64.0701121324060.2969@schroedinger.engr.sgi.com>
	<20070112135847.2d057e30.pj@sgi.com>
	<Pine.LNX.4.64.0701121359290.3087@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2007 14:00:16 -0800 (PST)
Christoph Lameter <clameter@sgi.com> wrote:

> On Fri, 12 Jan 2007, Paul Jackson wrote:
> 
> > It might look clearer to someone who is focused on that particular
> > change, but it adds unnecessary noise for the other 90% of the readers
> > of that code who are not concerned with cpusets at that point in time.
> 
> This is in NUMA specific code. And they should be concerned about cpusets 
> since cpusets may affect the node masks they can set. If this is hidden in 
> a macro then it may be overlooked.

bah.  No ifdefs!
