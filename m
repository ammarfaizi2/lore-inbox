Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261539AbSJ2EHB>; Mon, 28 Oct 2002 23:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261540AbSJ2EHB>; Mon, 28 Oct 2002 23:07:01 -0500
Received: from alpha2.its.monash.edu.au ([130.194.1.4]:22790 "EHLO
	ALPHA2.ITS.MONASH.EDU.AU") by vger.kernel.org with ESMTP
	id <S261539AbSJ2EHA>; Mon, 28 Oct 2002 23:07:00 -0500
Date: Tue, 29 Oct 2002 14:19:40 +1100 (EST)
From: netdev-bounce@oss.sgi.com
To: undisclosed-recipients:;
Message-id: <20021029031940.6F43212C73F@blammo.its.monash.edu.au>
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert wrote:

> > ...adding the whole profile output - sorted by the first column this time...
> >
> > 905182 total                                      0.4741
> > 121426 csum_partial_copy_generic                474.3203
> >  93633 default_idle                             1800.6346
> >  74665 do_wp_page                               111.1086
> 
> Perhaps the 'copy' also entails grabbing the page from disk, leading to
> inflated csum_partial_copy_generic stats?

I think this is strictly a copy from user space->kernel and vice versa.
This shouldnt include the disk access etc. 

thanks,
Nivedita


