Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbULOMyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbULOMyR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 07:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbULOMyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 07:54:17 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:32745 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261185AbULOMyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 07:54:15 -0500
Date: Wed, 15 Dec 2004 13:53:55 +0100
From: Jens Axboe <axboe@suse.de>
To: Sven Krohlas <sven@asbest-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Understanding schedular and slab allocation
Message-ID: <20041215125351.GB3034@suse.de>
References: <3byuD-2Z8-7@gated-at.bofh.it> <41C030D2.7080604@asbest-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C030D2.7080604@asbest-online.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15 2004, Sven Krohlas wrote:
> Btw: is anybody working on the slab allocator as described in Bonwicks
> 2001 paper?

Linux already fronts the slab allocator with per-cpu pools.

-- 
Jens Axboe

