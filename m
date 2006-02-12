Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWBLKqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWBLKqx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 05:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWBLKqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 05:46:53 -0500
Received: from smtp.dkm.cz ([62.24.64.34]:38149 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S1750791AbWBLKqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 05:46:52 -0500
Date: Sun, 12 Feb 2006 11:46:40 +0100
From: iSteve <isteve@rulez.cz>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Phillip Susi <psusi@cfl.rr.com>, linux-kernel@vger.kernel.org,
       Peter Osterlund <petero2@telia.com>
Subject: Re: Packet writing issue on 2.6.15.1
Message-ID: <20060212114640.31765c3a@silver>
In-Reply-To: <Pine.LNX.4.61.0602121129590.25363@yvahk01.tjqt.qr>
References: <20060211103520.455746f6@silver>
	<m3r76a875w.fsf@telia.com>
	<20060211124818.063074cc@silver>
	<m3bqxd999u.fsf@telia.com>
	<20060211170813.3fb47a03@silver>
	<43EE446C.8010402@cfl.rr.com>
	<20060211211440.3b9a4bf9@silver>
	<43EE8B20.7000602@cfl.rr.com>
	<20060212092315.10f3e0e2@silver>
	<Pine.LNX.4.61.0602121129590.25363@yvahk01.tjqt.qr>
X-Mailer: Sylpheed-Claws 2.0.0cvs42 (GTK+ 2.8.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Feb 2006 11:32:31 +0100 (MET)
Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> Like...?
> 
>   cdrwtool -d /dev/hdb -q
>   pktsetup 0 /dev/hdb
> 
> "Burning something non-udf there":
>   mkfs.xfs /dev/pktcdvd/0
>   mkisofs -o /dev/pktcdvd/0 somefiles
>   tar -cf /dev/pktcdvd/0 somemorefiles
> 
> Anything.

"without actually having to use UDF and packet writing on the burning
side" ... sorry, should've been 'or'. I am trying to find a way that wouldn't
require having packet writing support in kernel (or as module, of course) with
the initial burning.
-- 
 -- iSteve
