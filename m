Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbUDOTfJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 15:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbUDOTfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 15:35:09 -0400
Received: from havoc.gtf.org ([216.162.42.101]:20900 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261292AbUDOTfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 15:35:03 -0400
Date: Thu, 15 Apr 2004 15:32:58 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andi Kleen <ak@muc.de>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: SATA support merge in 2.4.27
Message-ID: <20040415193258.GA28951@havoc.gtf.org>
References: <1Ljts-1eQ-29@gated-at.bofh.it> <m37jwhqc2u.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m37jwhqc2u.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2004 at 09:24:09PM +0200, Andi Kleen wrote:
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> writes:
> 
> > Jeff Garzik sent me a SATA update to be merged in 2.4.x. 
> >
> > A lot of new boxes are shipping with SATA-only disks, and its pretty bad
> > to not have a "stable" series without such industry-standard support.
> >
> > This is the last feature to be merged on 2.4.x, and only because its quite 
> > necessary.
> >
> > Any oppositions?
> 
> The big problem is that the SATA code will move some disks from
> /dev/hdX to /dev/sdX (e.g. most disks in modern intel chipsets) And
> then the boxes don't boot anymore. It's probably a bad idea to merge
> it.

This statement is false for the majority of the SATA drivers.

Further, ata_piix is not included in the merge.

	Jeff



