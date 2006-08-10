Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbWHJFpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWHJFpT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 01:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbWHJFpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 01:45:18 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:50071 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932387AbWHJFpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 01:45:16 -0400
Date: Wed, 9 Aug 2006 22:44:59 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: mpm@selenic.com, npiggin@suse.de, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Simple Slab: A slab allocator with minimal meta information
In-Reply-To: <20060810144451.13591e4b.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.64.0608092243410.5928@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0608091744290.4966@schroedinger.engr.sgi.com>
 <20060810140153.e5932e76.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0608092211320.5806@schroedinger.engr.sgi.com>
 <20060810144451.13591e4b.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006, KAMEZAWA Hiroyuki wrote:

> Because of inode_init_once, many codes which uses inode uses initilization code.
> And inode is one of heavy users of slab.

Probably just code copied from the same location. It has the same name.
