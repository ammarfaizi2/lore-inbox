Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbVLAAFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbVLAAFi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbVLAAFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 19:05:38 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:15319 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751331AbVLAAFZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 19:05:25 -0500
Date: Wed, 30 Nov 2005 16:05:15 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: akpm@osdl.org, lhms-devel@lists.sourceforge.net,
       Cliff Wickman <cpw@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Direct Migration V6: Overview
In-Reply-To: <438E3B33.2030807@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.62.0511301604460.20743@schroedinger.engr.sgi.com>
References: <20051130171056.19405.95644.sendpatchset@schroedinger.engr.sgi.com>
 <438E3B33.2030807@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Dec 2005, KAMEZAWA Hiroyuki wrote:

> Christoph Lameter wrote:
> 
> > Changes V5->V6:
> > - Patchset against 2.6.15-rc3-mm1
> > - Remove checks for page count increases while migrating after Andrew
> > assured
> 
> Could you point where is changed in the code ?

The two checks for page_count > 1 where removed from migrate_page_copy().

