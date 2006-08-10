Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161266AbWHJOmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161266AbWHJOmB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 10:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161272AbWHJOmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 10:42:00 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:56719 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1161266AbWHJOmA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 10:42:00 -0400
Date: Thu, 10 Aug 2006 16:41:51 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Jeff Garzik <jeff@garzik.org>
cc: Andrew Morton <akpm@osdl.org>, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/9] sector_t format string
In-Reply-To: <44DB4224.7030303@garzik.org>
Message-ID: <Pine.LNX.4.64.0608101638420.6761@scrub.home>
References: <1155172843.3161.81.camel@localhost.localdomain>
 <20060809234019.c8a730e3.akpm@osdl.org> <Pine.LNX.4.64.0608101302270.6762@scrub.home>
 <44DB203A.6050901@garzik.org> <Pine.LNX.4.64.0608101409350.6762@scrub.home>
 <44DB25C1.1020807@garzik.org> <Pine.LNX.4.64.0608101429510.6762@scrub.home>
 <44DB27A3.1040606@garzik.org> <Pine.LNX.4.64.0608101459260.6761@scrub.home>
 <44DB3151.8050904@garzik.org> <Pine.LNX.4.64.0608101519560.6762@scrub.home>
 <44DB34FF.4000303@garzik.org> <Pine.LNX.4.64.0608101547261.6761@scrub.home>
 <44DB3D65.6030308@garzik.org> <Pine.LNX.4.64.0608101620350.6761@scrub.home>
 <44DB4224.7030303@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 10 Aug 2006, Jeff Garzik wrote:

> > With CONFIG_LBD disabled you still had the truncation/complexity issues
> > somewhere else, so you gain nothing, but waste memory in ext4.
> 
> You gain simplicity and reduced number of code paths.

Compared to other things it's almost nothing.

> "waste memory" is hardly a significant argument.  I doubt you will notice a
> difference.

Compared to other current waste, that's possible, but why do we have to 
make it worse and don't even make an effort to keep it a little under 
control?

bye, Roman
