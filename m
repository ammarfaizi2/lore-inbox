Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbQLFU1z>; Wed, 6 Dec 2000 15:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbQLFU1p>; Wed, 6 Dec 2000 15:27:45 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:13834
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129387AbQLFU1c>; Wed, 6 Dec 2000 15:27:32 -0500
Date: Wed, 6 Dec 2000 11:56:52 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Trashing ext2 with hdparm
In-Reply-To: <3A2E98E1.9B9732E4@Hell.WH8.TU-Dresden.De>
Message-ID: <Pine.LNX.4.10.10012061156190.21407-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Did you set and mount a "/var/shm" point?
 
On Wed, 6 Dec 2000, Udo A. Steinberg wrote:

> Hi,
> 
> Andre Hedrick wrote:
> > 
> > No way that this could cause corruption it is a read-only test.
> 
> As others pointed out, it's probably something related to shared
> memory, but it's definitely hdparm that triggers it. I haven't
> got the hdparm sources here to look at what exactly it's doing,
> but there is corruption going on, not on disk, but definitely in
> memory.
> 
> -Udo.
> 

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
