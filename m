Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbTI3JSn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 05:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbTI3JSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 05:18:43 -0400
Received: from users.linvision.com ([62.58.92.114]:45710 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S261246AbTI3JSl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 05:18:41 -0400
Date: Tue, 30 Sep 2003 11:18:36 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Cesar Eduardo Barros <cesarb@nitnet.com.br>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 1284] New: Asus P5AB broken BIOS reading ESCD
Message-ID: <20030930091836.GA31527@bitwizard.nl>
References: <42150000.1064850644@[10.10.2.4]> <20030929174127.GD26491@bitwizard.nl> <20030929222218.GE27908@flower.home.cesarb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030929222218.GE27908@flower.home.cesarb.net>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 07:22:18PM -0300, Cesar Eduardo Barros wrote:
> On Mon, Sep 29, 2003 at 07:41:27PM +0200, Erik Mouw wrote:
> > FWIW: I used to have a similar board (Asus P5A, it actually died a week
> > ago, so I can't check anything anymore). Never tried 2.6 on it, but I
> > know it had a flakey PnPBIOS implementation: if you put in a Sound
> > Blaster AWE64 Gold, you couldn't use the floppy drive anymore. The
> > latest "Y2K compliant" BIOS (revision 1.005 IIRC) fixed that, it might
> > also fix this particular bug.
> > 
> 
> The latest BIOS (a beta one) still has the same problem. Also, it breaks
> the main timer (for instance, vmstat 1 takes 2-3 seconds between lines,
> and the kernel complains about a broken TSC on boot).

As far as I remember I didn't try the beta BIOS, the latest stable one
fixed my problems with the Sound Blaster and the floppy drive. I only
used the board with 2.4 (last kernel I ran was 2.4.20-rmap15i) and that
worked OK. If that still doesn't solve your problem, I agree the BIOS
has to be blacklisted so we can work around it.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
| Data lost?!
| Stay calm and contact Harddisk-recovery.com!
