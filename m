Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314341AbSDRNCK>; Thu, 18 Apr 2002 09:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314342AbSDRNCJ>; Thu, 18 Apr 2002 09:02:09 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:61192 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S314341AbSDRNCH>;
	Thu, 18 Apr 2002 09:02:07 -0400
Date: Thu, 18 Apr 2002 15:01:20 +0200
From: Jens Axboe <axboe@suse.de>
To: Sebastian Droege <sebastian.droege@gmx.de>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE TCQ #4
Message-ID: <20020418130120.GG2492@suse.de>
In-Reply-To: <20020415125606.GR12608@suse.de> <02db01c1e498$7180c170$58dc703f@bnscorp.com> <20020416102510.GI17043@suse.de> <20020416200051.7ae38411.sebastian.droege@gmx.de> <20020416180914.GR1097@suse.de> <20020416204329.4c71102f.sebastian.droege@gmx.de> <3CBD28D1.6070702@evision-ventures.com> <20020417132852.4cf20276.sebastian.droege@gmx.de> <3CBD519F.7080207@evision-ventures.com> <20020418141746.2df4a948.sebastian.droege@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18 2002, Sebastian Droege wrote:
> This happens only (?) when I put hdparm -qa1 -qA1 -qc1 -qd1 -qm16 -qu1 -qW1 /dev/hda (the same with hdb) in my bootscripts

btw, using -mXX and -d1 at the same time makes no sense, -m is multi pio
setting and has no impact when using dma. write caching is ready enabled
with tcq currently, so you don't need to do that either.

-- 
Jens Axboe

