Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161305AbWHJOWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161305AbWHJOWG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 10:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161309AbWHJOWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 10:22:05 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:33506 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161305AbWHJOWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 10:22:04 -0400
Message-ID: <44DB4107.5050001@garzik.org>
Date: Thu, 10 Aug 2006 10:21:59 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Eric Sandeen <sandeen@sandeen.net>, Andrew Morton <akpm@osdl.org>,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       cmm@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 2/9] sector_t format string
References: <1155172843.3161.81.camel@localhost.localdomain> <20060809234019.c8a730e3.akpm@osdl.org> <Pine.LNX.4.64.0608101302270.6762@scrub.home> <44DB203A.6050901@garzik.org> <Pine.LNX.4.64.0608101409350.6762@scrub.home> <44DB25C1.1020807@garzik.org> <Pine.LNX.4.64.0608101429510.6762@scrub.home> <44DB27A3.1040606@garzik.org> <Pine.LNX.4.64.0608101459260.6761@scrub.home> <44DB3151.8050904@garzik.org> <Pine.LNX.4.64.0608101519560.6762@scrub.home> <44DB34FF.4000303@garzik.org> <Pine.LNX.4.64.0608101547261.6761@scrub.home> <44DB3CED.7080802@sandeen.net> <Pine.LNX.4.64.0608101612390.6761@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0608101612390.6761@scrub.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Hi,
> 
> On Thu, 10 Aug 2006, Eric Sandeen wrote:
> 
>> ext4 is being developed primarily to address scaling issues at the high end of
>> the storage spectrum.  If you're concerned about carrying 64-bit containers,
>> just use ext3, and be happy with your 32-bit, < 16TB filesystems, I'd say.
> 
> The problem being that it doesn't _exclusively_ address scaling issues, 
> some new features may well be interesting to non high end users as well. 
> If it's supposed to be a high end only fs, then please don't call ext4, 
> otherwise it would mislead users about what it doesn't is - a general 
> purpose fs.

It will work just fine on 32-bit machines.

You're making a mountain out of a molehill.

	Jeff



