Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263727AbTEYUO2 (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 25 May 2003 16:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263731AbTEYUO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 16:14:28 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:16071
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263727AbTEYUO1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 16:14:27 -0400
Subject: Re: 2.4.21-rc3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Philippe =?ISO-8859-1?Q?Gramoull=E9?= <pgramoul@nerim.net>,
   Russell Coker <russell@coker.com.au>, reiserfs <reiserfs-list@namesys.com>,
   Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200305241712.23316.Dieter.Nuetzel@hamburg.de>
References: <200305232256.17604.russell@coker.com.au>
	 <20030523161356.7986c5d6.pgramoul@nerim.net>
	 <200305241712.23316.Dieter.Nuetzel@hamburg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Organization: 
Message-Id: <1053890873.15242.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 May 2003 20:27:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-05-24 at 16:12, Dieter Nützel wrote:
> > IIRC, according to Alan Cox, on LKML, IDE shouldn't even work as a module,
> > well, if you value your data.

Thats only true for loading drivers into a live system where the drive
is already active in legacy mode, and its not something 2.4.19 allowed
so I disabled it again

> > So why don't you include IDE statically in your kernel ?
> 
> Because it worked for ages and do NOT since 2.4.19 or so.
> 
> I have all SCSI and need ATA/IDE only from time to time to recover bad ATA/IDE 
> disks for some friends or customers.
> 
> ATA/IDE shouldn't be demanded thing in the kernel.

Sure. someone just has to fix the makefiles

