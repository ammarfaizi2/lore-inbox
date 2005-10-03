Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbVJCVFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbVJCVFc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 17:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbVJCVFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 17:05:32 -0400
Received: from orb.pobox.com ([207.8.226.5]:14512 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S932356AbVJCVFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 17:05:31 -0400
Message-ID: <43419D0C.4010002@rtr.ca>
Date: Mon, 03 Oct 2005 17:05:16 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050728
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
Cc: jmerkey <jmerkey@utah-nac.org>, Nuno Silva <nuno.silva@vgertech.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux SATA S.M.A.R.T. and SLEEP?
References: <Pine.LNX.4.63.0509290916450.20827@p34> <433C31C8.1030901@vgertech.com> <Pine.LNX.4.63.0509291433340.13272@p34> <433C2A11.9090506@utah-nac.org> <43415D14.5070909@tmr.com>
In-Reply-To: <43415D14.5070909@tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
>
> It would be great to have some way to match drives with names, but there 
> doesn't seem to be a single solution for PATA, SATA, SCSI and hotplug. 
> Something like mounts using UUID of the filesystem, but for the drives.

I believe it would be pretty easy for userspace hotplug scripts
(udev and pals) to assign drives names by matching model/serialno,
if that's what you had in mind.

cheers
