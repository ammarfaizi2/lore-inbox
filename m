Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262575AbVHDOvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbVHDOvI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 10:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbVHDOs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 10:48:56 -0400
Received: from silver.veritas.com ([143.127.12.111]:29112 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S262575AbVHDOqu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 10:46:50 -0400
Date: Thu, 4 Aug 2005 15:48:35 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Matti Aarnio <matti.aarnio@zmailer.org>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Anton Blanchard <anton@samba.org>, cr@sap.com, linux-mm@kvack.org
Subject: Re: Getting rid of SHMMAX/SHMALL ?
In-Reply-To: <20050804142040.GB22165@mea-ext.zmailer.org>
Message-ID: <Pine.LNX.4.61.0508041547500.4373@goblin.wat.veritas.com>
References: <20050804113941.GP8266@wotan.suse.de>
 <Pine.LNX.4.61.0508041409540.3500@goblin.wat.veritas.com>
 <20050804132338.GT8266@wotan.suse.de> <20050804142040.GB22165@mea-ext.zmailer.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 04 Aug 2005 14:46:47.0873 (UTC) FILETIME=[574FDB10:01C59903]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Aug 2005, Matti Aarnio wrote:
> 
> SHM resources are non-swappable, thus I would not by default
> let user programs go and allocate very much SHM spaces at all.

No, SHM resources are swappable.

Hugh
