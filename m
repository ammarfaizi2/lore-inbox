Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265131AbRFZWYn>; Tue, 26 Jun 2001 18:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265133AbRFZWYd>; Tue, 26 Jun 2001 18:24:33 -0400
Received: from asooo.flowerfire.com ([63.104.96.247]:13583 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S265131AbRFZWY1>; Tue, 26 Jun 2001 18:24:27 -0400
Date: Tue, 26 Jun 2001 17:24:23 -0500
From: Ken Brownfield <brownfld@irridia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Tracking down semaphore usage/leak
Message-ID: <20010626172421.A17393@asooo.flowerfire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <no.id>; from brownfld@irridia.com on Tue, Jun 26, 2001 at 02:09:16PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Urgh, learn something new everyday (ipcs, ipcrm).  My apologies; apropos
didn't catch it on my boxes. :-(
-- 
Ken.
brownfld@irridia.com

On Tue, Jun 26, 2001 at 02:09:16PM -0700, Ken Brownfield wrote:
| With RedHat's new Samba 2.0.10 RPM (the one to patch the latest 
| vulnerability) they seem to have sniffed enough glue to start using SysV 
| IPC semaphores which apparently leak until SEM??? are reached.  semget() 
| is returning "No space left on device", and disk/inodes/memory are all 
| fine.
| 
| Anyway, could someone give me a very quick rundown of the options for 
| tracking/force-freeing semaphores, or how to determine from proc, if 
| possible, what the current semaphore allocation status is?  Or did RH 
| slay a machine I really don't want to reboot?  I've restarted all 
| semaphore-using processes to no avail, but even so the SEM??? limits are 
| far above the normal needs of this machine.
| 
| Thanks much.  Searched the archives/Google/FAQ/semaphore docs; sorry if 
| it's been covered.  I'll summarize if folks want to hit me on or off the 
| list.
| --
| Ken.
| brownfld@irridia.com
