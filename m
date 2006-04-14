Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWDNBd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWDNBd0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 21:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWDNBdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 21:33:25 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:45275 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932090AbWDNBdY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 21:33:24 -0400
Date: Thu, 13 Apr 2006 18:33:07 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: akpm@osdl.org, hugh@veritas.com, linux-kernel@vger.kernel.org,
       lee.schermerhorn@hp.com, linux-mm@kvack.org, taka@valinux.co.jp,
       marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 5/5] Swapless V2: Revise main migration logic
In-Reply-To: <20060414101959.d59ac82d.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.64.0604131832020.16220@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
 <20060413235432.15398.23912.sendpatchset@schroedinger.engr.sgi.com>
 <20060414101959.d59ac82d.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2006, KAMEZAWA Hiroyuki wrote:

> For hotremove (I stops it now..), we should fix this later (if we can do).
> If new SWP_TYPE_MIGRATION swp entry can contain write protect bit,
> hotremove can avoid copy-on-write but things will be more complicated.

This is a known issue.I'd be glad if you could come up with a working 
scheme to solve this that is simple.

