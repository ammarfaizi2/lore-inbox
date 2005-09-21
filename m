Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbVIURp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbVIURp1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 13:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbVIURp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 13:45:27 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:57502 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751306AbVIURp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 13:45:27 -0400
Date: Wed, 21 Sep 2005 10:45:23 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Jay Lan <jlan@engr.sgi.com>
cc: Hugh Dickins <hugh@veritas.com>,
       Frank van Maarseveen <frankvm@frankvm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2] fix incorrect mm->hiwater_vm and mm->hiwater_rss
In-Reply-To: <4331990A.80904@engr.sgi.com>
Message-ID: <Pine.LNX.4.62.0509211045110.10810@schroedinger.engr.sgi.com>
References: <20050921121915.GA14645@janus> <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com>
 <43319111.1050803@engr.sgi.com> <Pine.LNX.4.61.0509211802150.8880@goblin.wat.veritas.com>
 <4331990A.80904@engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2005, Jay Lan wrote:

> I think the best approach would be to wrap the mm usage accounting
> in a new CONFIG_ENHANCED_SYS_ACCT and leave it OFF by default so that
> people can still get the minimal accounting with
> CONFIG_BSD_PROCESS_ACCT.

Sounds okay.

