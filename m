Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278890AbRKFKh0>; Tue, 6 Nov 2001 05:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278968AbRKFKhF>; Tue, 6 Nov 2001 05:37:05 -0500
Received: from trout.hpc.CSIRO.AU ([138.194.72.10]:37279 "EHLO
	trout.hpc.CSIRO.AU") by vger.kernel.org with ESMTP
	id <S278890AbRKFKg5>; Tue, 6 Nov 2001 05:36:57 -0500
Message-Id: <200111061036.VAA07886@trout.hpc.CSIRO.AU>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: Re: Red Hat needs this patch (was Re: handling NFSERR_JUKEBOX) 
In-Reply-To: Your message of "06 Nov 2001 10:05:19 BST."
             <shswv14w9ps.fsf@charged.uio.no> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 06 Nov 2001 21:36:54 +1100
From: Bob Smart <smart@hpc.CSIRO.AU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If all you do is intercept read and setattr, then you certainly
> haven't achieved 'enterprise quality'.

I don't have documentation on when Cray's NFSv3 server will return
NFSERR_JUKEBOX, but since inodes aren't migrated to tape I don't
think it is likely on other than read and non-truncate write with
no prior read. Our applications are unlikely to do the latter.

Maybe there is a subset of servers for which the patch is OK, and
we could make that clear in the help for the config option. I'll
ask Cray for clarification about their server.

Bob
