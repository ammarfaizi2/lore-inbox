Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbUCCMXJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 07:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262452AbUCCMXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 07:23:09 -0500
Received: from grassmarket.ucs.ed.ac.uk ([129.215.166.64]:25335 "EHLO
	grassmarket.ucs.ed.ac.uk") by vger.kernel.org with ESMTP
	id S262451AbUCCMXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 07:23:05 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Reply-To: s0348365@sms.ed.ac.uk
Organization: University of Edinburgh
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] 2.6 ide-cd DMA ripping
Date: Wed, 3 Mar 2004 12:26:21 +0000
User-Agent: KMail/1.6
References: <20040303113756.GQ9196@suse.de>
In-Reply-To: <20040303113756.GQ9196@suse.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403031226.22015.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 March 2004 11:37, you wrote:
> Hi,
>
> 2.6 still uses PIO for CDROMREADAUDIO cdda ripping, which is less than
> optimal of course... This patch uses the block layer infrastructure to
> enable zero copy DMA ripping through CDROMREADAUDIO.
>
> I'd appreciate people giving this a test spin. Patch is against
> 2.6.4-rc1 (well current BK, actually).
>
[snip] 

Is this a general optimisation, i.e. will the rip methods used by cdda2wav and 
cdparanoia, etc. be optimised, or do you need some specific userspace tools 
to utilise it?

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/AI Undergraduate
contact:    7/10 Darroch Court,
            University of Edinburgh.
