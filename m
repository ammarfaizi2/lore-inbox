Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbWGDFuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbWGDFuT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 01:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWGDFuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 01:50:19 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:27113 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751043AbWGDFuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 01:50:18 -0400
Date: Tue, 4 Jul 2006 14:52:13 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, hugh@veritas.com,
       kernel@kolivas.org, marcelo@kvack.org, nickpiggin@yahoo.com.au,
       clameter@sgi.com, ak@suse.de
Subject: Re: [RFC 8/8] Fix i386 SRAT check for MAX_NR_ZONES
Message-Id: <20060704145213.75cc5cf5.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060703215616.7566.56782.sendpatchset@schroedinger.engr.sgi.com>
References: <20060703215534.7566.8168.sendpatchset@schroedinger.engr.sgi.com>
	<20060703215616.7566.56782.sendpatchset@schroedinger.engr.sgi.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jul 2006 14:56:16 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> swap_prefetch: Make use of ZONE_HIGHMEM conditional
> 

This patch is same to 
[RFC 5/8] swap_prefetch: Make use of ZONE_HIGHMEM dependend on CONFIG_HIGHMEM

please check. I think what you intended was patch against chunk_to_zones().

-Kame

