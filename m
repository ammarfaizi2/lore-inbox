Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283443AbRK3A2P>; Thu, 29 Nov 2001 19:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283444AbRK3A2F>; Thu, 29 Nov 2001 19:28:05 -0500
Received: from sproxy.gmx.net ([213.165.64.20]:42361 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S283443AbRK3A17>;
	Thu, 29 Nov 2001 19:27:59 -0500
Date: Fri, 30 Nov 2001 01:27:52 +0100
From: Rene Rebe <rene.rebe@gmx.net>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: linux-kernel@vger.kernel.org, ziegler@informatik.hu-berlin.de
Subject: Re: IDE controller detection 2.4 +devfs
Message-Id: <20011130012752.0fd5380a.rene.rebe@gmx.net>
In-Reply-To: <200111300017.fAU0Hx704241@vindaloo.ras.ucalgary.ca>
In-Reply-To: <20011130001138.78ab1242.rene.rebe@gmx.net>
	<200111300017.fAU0Hx704241@vindaloo.ras.ucalgary.ca>
Organization: FreeSourceCommunity ;-)
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2001 17:17:59 -0700
Richard Gooch <rgooch@ras.ucalgary.ca> wrote:

> Rene Rebe writes:

[...]

> So what's the problem? It's a similar naming scheme as used for
> SCSI. It doesn't matter if you have something plugged into a bus, the
> host numbering doesn't change. This is a Feature[tm].

Aeh? I can not follow. I feel completely comfortable with the names (strings)
or subdirs, you use. My problem: I have 2 ide-controllers. I would like
to get them as host0 and host1. Boths with the sub-dirs bus0 and bus1.
Reading your answer I though you mean it is fixed due to the pci-id's - but
they do not match ...

And disabling one channel in the bios shouldn't move the controller
from host0 to host1 ... - I do not see the system-behind that ...

Btw. Thanks for DevFS it really ROCKs!! (Except that USBfs exists
and I can not maintain / controll it via the devfsd :-(()

> If you want to access your drives according to detection order, use
> /dev/discs instead.

Yes I know about this.

> 				Regards,
> 
> 					Richard....
> Permanent: rgooch@atnf.csiro.au
> Current:   rgooch@ras.ucalgary.ca


k33p h4ck1n6
  René

-- 
René Rebe (Registered Linux user: #127875 <http://counter.li.org>)

eMail:    rene.rebe@gmx.net
          rene@rocklinux.org

Homepage: http://www.tfh-berlin.de/~s712059/index.html

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
