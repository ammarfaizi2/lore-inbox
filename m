Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161308AbWHJOUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161308AbWHJOUO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 10:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161307AbWHJOUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 10:20:14 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:43407 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1161243AbWHJOUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 10:20:12 -0400
Date: Thu, 10 Aug 2006 16:19:54 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Eric Sandeen <sandeen@sandeen.net>
cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       cmm@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 2/9] sector_t format string
In-Reply-To: <44DB3CED.7080802@sandeen.net>
Message-ID: <Pine.LNX.4.64.0608101612390.6761@scrub.home>
References: <1155172843.3161.81.camel@localhost.localdomain>
 <20060809234019.c8a730e3.akpm@osdl.org> <Pine.LNX.4.64.0608101302270.6762@scrub.home>
 <44DB203A.6050901@garzik.org> <Pine.LNX.4.64.0608101409350.6762@scrub.home>
 <44DB25C1.1020807@garzik.org> <Pine.LNX.4.64.0608101429510.6762@scrub.home>
 <44DB27A3.1040606@garzik.org> <Pine.LNX.4.64.0608101459260.6761@scrub.home>
 <44DB3151.8050904@garzik.org> <Pine.LNX.4.64.0608101519560.6762@scrub.home>
 <44DB34FF.4000303@garzik.org> <Pine.LNX.4.64.0608101547261.6761@scrub.home>
 <44DB3CED.7080802@sandeen.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 10 Aug 2006, Eric Sandeen wrote:

> ext4 is being developed primarily to address scaling issues at the high end of
> the storage spectrum.  If you're concerned about carrying 64-bit containers,
> just use ext3, and be happy with your 32-bit, < 16TB filesystems, I'd say.

The problem being that it doesn't _exclusively_ address scaling issues, 
some new features may well be interesting to non high end users as well. 
If it's supposed to be a high end only fs, then please don't call ext4, 
otherwise it would mislead users about what it doesn't is - a general 
purpose fs.

bye, Roman
