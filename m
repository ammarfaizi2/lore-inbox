Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbWDKRJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbWDKRJp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 13:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbWDKRJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 13:09:45 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:18142 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751042AbWDKRJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 13:09:44 -0400
Date: Tue, 11 Apr 2006 10:09:18 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Mingming Cao <cmm@us.ibm.com>
cc: akpm@osdl.org, kiran@scalex86.org,
       Laurent Vivier <Laurent.Vivier@bull.net>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] ext3 percpu counter fixes to suppport for ext3
 unsigned long type free blocks counter
In-Reply-To: <1144691929.3964.53.camel@dyn9047017067.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.64.0604111007230.564@schroedinger.engr.sgi.com>
References: <1144691929.3964.53.camel@dyn9047017067.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Apr 2006, Mingming Cao wrote:

> Here are the proposed patches to allow the ext3 free block accounting
> works with more than 8TB storage.

Umm.. This is an issue on 32 bit platforms only. 64bit platforms x86_64, 
ia64 etc do not need this. Would you make it arch specific?
