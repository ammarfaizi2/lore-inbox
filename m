Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261908AbTBKPK0>; Tue, 11 Feb 2003 10:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261996AbTBKPK0>; Tue, 11 Feb 2003 10:10:26 -0500
Received: from mail5.bluewin.ch ([195.186.1.207]:47103 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id <S261908AbTBKPKZ>;
	Tue, 11 Feb 2003 10:10:25 -0500
Date: Tue, 11 Feb 2003 16:04:51 +0100
From: Roger Luethi <rl@hellgate.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.5.60] swsuspend -> BUG at drivers/ide/ide-disk.c:1557
Message-ID: <20030211150451.GA1338@k3.hellgate.ch>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030211131151.GA1262@k3.hellgate.ch> <20030211132132.GA20750@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030211132132.GA20750@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.60 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Feb 2003 14:21:32 +0100, Pavel Machek wrote:
> > Is software suspend in Vanilla 2.5.60 supposed to work? A modified shutdown
> > (using the reboot(2) magic) triggers the BUG_ON in idedisk_suspend. A quick
> > check with older 2.5.x indicates this problem has been around for a
> > while.
> 
> It works for me in 2.5.59. I'm now downloading 2.5.60.

I just saw it happen on 2.5.59 as well. FWIW the machine has 1 GB of RAM,
but HIGHMEM is off for this particular kernel. I won't post jpeg to lkml,
but screen shots are available upon request.

Roger
