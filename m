Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWDKTBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWDKTBS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 15:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbWDKTBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 15:01:18 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:36821 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750991AbWDKTBR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 15:01:17 -0400
Subject: Re: [RFC][PATCH 0/3] ext3 percpu counter fixes to suppport for
	ext3 unsigned long type free blocks counter
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, kiran@scalex86.org,
       Laurent Vivier <Laurent.Vivier@bull.net>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0604111007230.564@schroedinger.engr.sgi.com>
References: <1144691929.3964.53.camel@dyn9047017067.beaverton.ibm.com>
	 <Pine.LNX.4.64.0604111007230.564@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Tue, 11 Apr 2006 12:01:13 -0700
Message-Id: <1144782073.3986.15.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-11 at 10:09 -0700, Christoph Lameter wrote:
> On Mon, 10 Apr 2006, Mingming Cao wrote:
> 
> > Here are the proposed patches to allow the ext3 free block accounting
> > works with more than 8TB storage.
> 
> Umm.. This is an issue on 32 bit platforms only. 64bit platforms x86_64, 
> ia64 etc do not need this. Would you make it arch specific?

Yes, make sense. I will update my patch soon. Thanks.


Mingming



