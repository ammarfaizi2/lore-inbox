Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263104AbTCLIlS>; Wed, 12 Mar 2003 03:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263105AbTCLIlS>; Wed, 12 Mar 2003 03:41:18 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:53663 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263104AbTCLIlR>;
	Wed, 12 Mar 2003 03:41:17 -0500
Date: Wed, 12 Mar 2003 09:51:45 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: scott thomason <scott-kernel@thomasons.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bio too big device
Message-ID: <20030312085145.GJ811@suse.de>
References: <200303112055.31854.scott-kernel@thomasons.org> <Pine.LNX.4.10.10303112100270.391-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10303112100270.391-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 11 2003, Andre Hedrick wrote:
> 
> That has to be a BIO bug or IDE setup bug.

raid bug

> 256 sectors is legal and correct for 28-bit addressing.

yes, but ide itself limits incoming requests to 255 sectors. so it
cannot get 256 sector requests.

-- 
Jens Axboe

