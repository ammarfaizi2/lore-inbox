Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268054AbUHXQVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268054AbUHXQVu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 12:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268066AbUHXQVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 12:21:50 -0400
Received: from alumni.cs.wisc.edu ([128.105.2.11]:18654 "EHLO
	alumni.cs.wisc.edu") by vger.kernel.org with ESMTP id S268054AbUHXQVs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 12:21:48 -0400
Date: Tue, 24 Aug 2004 11:21:47 -0500
From: Will McDonald <will@cs.wisc.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4: Mount of /dev/hdb1 impssible
Message-ID: <20040824162147.GG24167@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-Key: http://www.upl.cs.wisc.edu/~will/pubkey.asc
X-GPG-Fingerprint: DDD6 4020 6A8C 712E 2211  826C D5F9 D8E5 F433 2B28
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For the benefit of those searching list archives:

I had this problem while upgrading from 2.6.2 to 2.6.6 (and 2.6.7/2.6.8), so
the problems seems to have arrision in either 2.6.3 or 2.6.4.

The solution (at least for a few people who have experienced this) is to
remove the evms package. Look for the existence of (on my system) /dev/evms/.

Not strictly necessary, but can anyone in the know explain why this broke?

-will

On Thu, 11 Mar 2004 21:29:53 +0200, Markus Hstbacka wrote:
> Hi list,
> I upgraded from 2.6.4-rc2 to 2.6.4 today, a few minutes before reboot I
> noticed that my /dev/hdb1 hadn't been mounted on last reboot, so I tried
> to mount it by hand:
> # mount /work
> mount: /dev/hdb1 already mounted or /work/ busy
> 
> Then I thought it'll be fixed when I boot up my 2.6.4, it wasn't, I
> tried to mount it to various locations (/mnt/ /mnt/work etc..) and it
> didn't want to mount, I'm totally out of ideas with this. according to
> df it's not mounted, according to mount it's not mounted and according
> to mtab it's not mounted, so what's going on?
> 
> It mounts fine on my 2.6.1-mm4 kernel that I use for SCSI burning and
> fallback if something fails.

