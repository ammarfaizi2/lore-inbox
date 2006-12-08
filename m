Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760805AbWLHSZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760805AbWLHSZm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 13:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760815AbWLHSZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 13:25:41 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:41127 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760805AbWLHSZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 13:25:12 -0500
Date: Fri, 8 Dec 2006 13:24:48 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org, hch@infradead.org,
       viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com
Subject: Re: [PATCH 26/35] Unionfs: Privileged operations workqueue
Message-ID: <20061208182448.GA24478@filer.fsl.cs.sunysb.edu>
References: <Pine.LNX.4.61.0612052020420.18570@yvahk01.tjqt.qr> <20061205195013.GE2240@filer.fsl.cs.sunysb.edu> <20061206173245.GA23405@filer.fsl.cs.sunysb.edu> <Pine.LNX.4.61.0612061939340.16042@yvahk01.tjqt.qr> <20061208021714.GA14363@filer.fsl.cs.sunysb.edu> <Pine.LNX.4.61.0612081134360.12227@yvahk01.tjqt.qr> <20061208160038.GA17707@filer.fsl.cs.sunysb.edu> <Pine.LNX.4.61.0612081801240.20988@yvahk01.tjqt.qr> <20061208174306.GA22299@filer.fsl.cs.sunysb.edu> <Pine.LNX.4.61.0612081900050.3108@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0612081900050.3108@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2006 at 07:03:00PM +0100, Jan Engelhardt wrote:
> On Dec 8 2006 12:43, Josef Sipek wrote:
...
> >args->err is modified. If args is declared const, gcc complains.
> 
> I never said making "args" const, but
> rather [-> http://lkml.org/lkml/2006/12/5/210 ] I said:
> 
>   "Care to make that: const struct mknod_args *m = &args->mknod;?"

Eeek. Sorry.

Josef "Jeff" Sipek.

-- 
NT is to UNIX what a doughnut is to a particle accelerator.
