Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272337AbTHIL4s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 07:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272338AbTHIL4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 07:56:48 -0400
Received: from www.13thfloor.AT ([212.16.59.250]:3760 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S272337AbTHIL4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 07:56:47 -0400
Date: Sat, 9 Aug 2003 13:56:57 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Norbert Preining <preining@logic.at>
Cc: gaxt <gaxt@rogers.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3 cannot mount root fs
Message-ID: <20030809115656.GC27013@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Norbert Preining <preining@logic.at>,
	gaxt <gaxt@rogers.com>, linux-kernel@vger.kernel.org
References: <3F34D0EA.8040006@rogers.com> <20030809104024.GA12316@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20030809104024.GA12316@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 09, 2003 at 12:40:24PM +0200, Norbert Preining wrote:
> On Sam, 09 Aug 2003, gaxt wrote:
> > Try changing in your bootloader root=/dev/hdb1 to root=341
> 
> tried it already with 
> 	root=0341
> and 
> 	root=341
> on the lilo prompt. No change.
> 
> (Beside the kernel telling me:
> 	VFS: Cannot mount root fs "341" or "hdb1"

are you using devfs? if so, the devfs device name
would be apropriate root=/dev/ide/host0/bus0/target1/lun0/part1

how does the lilo config look like, and what kernel
command line is reported on boot ...

best,
Herbert

> Best wishes
> 
> Norbert
