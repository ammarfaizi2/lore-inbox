Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261604AbREOVx2>; Tue, 15 May 2001 17:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261618AbREOVxU>; Tue, 15 May 2001 17:53:20 -0400
Received: from [195.63.194.11] ([195.63.194.11]:4621 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S261597AbREOVwC>;
	Tue, 15 May 2001 17:52:02 -0400
Message-ID: <3B01A4CA.1B875DE6@evision-ventures.com>
Date: Tue, 15 May 2001 23:51:06 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SCSI disk minor number cleaning
In-Reply-To: <200105152035.WAA23563@green.mif.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrzej Krzysztofowicz wrote:
> 
> Hi,
>   The following patch cleans up a bit usage of parameters related to
> number of minors per disk in the SCSI subsystem. This is a preliminary
> patch and it seems to not contain any problematic changes. The full version
> of the patch (that allows to succesfully change SCSI_MINOR_SHIFT and use
> more/less partitions per disk) is available at
> 
> ftp://rudy.mif.pg.gda.pl/pub/People/ankry/patches/scsi-minor/
> 
> Both are against 2.4.4-ac9, but the "shorter" one can be applied to
> 2.4.5-pre series as well.
> 
> Any comments are welcome.

Good stuff!  This is at least tagging where the problems are!
