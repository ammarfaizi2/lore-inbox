Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281118AbRLDFFi>; Tue, 4 Dec 2001 00:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281854AbRLDFF2>; Tue, 4 Dec 2001 00:05:28 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:16578 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S281118AbRLDFFK>; Tue, 4 Dec 2001 00:05:10 -0500
Date: Mon, 3 Dec 2001 22:04:58 -0700
Message-Id: <200112040504.fB454w900399@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] wait_for_devfsd_finished deadlock
In-Reply-To: <20011201191113.A1034@holomorphy.com>
In-Reply-To: <20011201191113.A1034@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin, III writes:
> While testing 2.4.17-pre1 with some other patches, a situation
> reminiscent of a deadlock arose. mutt(1) would block indefinitely
> while opening a large mbox, and all further calls to sys_open()
> would block indefinitely.
> 
> After some further testing to isolate the problem, I reproduced this
> behavior in the vanilla 2.4.17-pre1 kernel. The sysrq output showed
> a number of processes with the following call trace in the devfs
> core:
[...]

Just a followup: did you get around to trying devfs-patch-v199.2 ?
That should fix the problem.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
