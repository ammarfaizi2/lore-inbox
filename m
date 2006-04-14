Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965085AbWDNBim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965085AbWDNBim (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 21:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965092AbWDNBil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 21:38:41 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:37611 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S965085AbWDNBil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 21:38:41 -0400
Date: Fri, 14 Apr 2006 10:40:20 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, hugh@veritas.com, linux-kernel@vger.kernel.org,
       lee.schermerhorn@hp.com, linux-mm@kvack.org, taka@valinux.co.jp,
       marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 5/5] Swapless V2: Revise main migration logic
Message-Id: <20060414104020.866ed279.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <Pine.LNX.4.64.0604131832020.16220@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
	<20060413235432.15398.23912.sendpatchset@schroedinger.engr.sgi.com>
	<20060414101959.d59ac82d.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0604131832020.16220@schroedinger.engr.sgi.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Apr 2006 18:33:07 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> On Fri, 14 Apr 2006, KAMEZAWA Hiroyuki wrote:
> 
> > For hotremove (I stops it now..), we should fix this later (if we can do).
> > If new SWP_TYPE_MIGRATION swp entry can contain write protect bit,
> > hotremove can avoid copy-on-write but things will be more complicated.
> 
> This is a known issue.I'd be glad if you could come up with a working 
> scheme to solve this that is simple.
> 

Hmm. I'll post sample implemntation on your patch, later.

-Kame

