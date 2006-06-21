Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWFUOLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWFUOLe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWFUOLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:11:34 -0400
Received: from aun.it.uu.se ([130.238.12.36]:30141 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1750758AbWFUOLd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:11:33 -0400
Date: Wed, 21 Jun 2006 16:11:06 +0200 (MEST)
Message-Id: <200606211411.k5LEB6aw013557@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: kernel@wildsau.enemy.org, linux-kernel@vger.kernel.org
Subject: Re: gcc-4.1.1 and kernel-2.4.32
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006 15:17:34 +0200 (MET DST), Herbert Rosmanith wrote:
> trying to compile 2.4.32 with gcc-4.1.1 (probably any 4.x gcc?) produces
> a lot of errors, (i.e., declaration of symbols of different types and so on).
> 
> I wonder if it is planned to be fixed? No idea who's maintaining it - 
> in case you want to, I could send you diffs to make 2.4.32 compile.

Not reading LKML much, eh? Anyway, it's already being taken care of; see
<http://marc.theaimsgroup.com/?l=linux-kernel&m=115058555819917&w=2> for
well-tested patches for 2.4.33-rc1. They probably apply to 2.4.32 as well.

The powers that be have decreed that gcc-4 fixes won't be accepted
into the official 2.4 kernel, which is a pity since they are smaller
and simpler than the gcc-3.4 fixes which did get included.

/Mikael
