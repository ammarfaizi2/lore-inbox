Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbQLDBHH>; Sun, 3 Dec 2000 20:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130159AbQLDBG5>; Sun, 3 Dec 2000 20:06:57 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:65031 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129324AbQLDBGo>; Sun, 3 Dec 2000 20:06:44 -0500
Date: Sun, 3 Dec 2000 18:32:36 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-11 AIC7xxx.o driver barfs on AHA27XX adapter
Message-ID: <20001203183236.A24895@vger.timpanogas.org>
In-Reply-To: <20001203181524.A24809@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001203181524.A24809@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Sun, Dec 03, 2000 at 06:15:24PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2000 at 06:15:24PM -0700, Jeff V. Merkey wrote:
> 
> 
> On a four processor POCA system with dual Fast-SCSI AHA274X/VLB bus
> controllers I am seeing the following timeout errors right after
> the sequencer scripts are downloaded and the driver starts polling.
> It does not happen when compiled in kernel, only when loaded from 
> an initrd image.  The root FS is getting mounted properly and
> probing and loading the driver.
> 
> aborting command due to timeout:  pid 00 scsi 00 channel 00 lun 00 
> inquiry 00 00 00 ff 00
> 
> The machine then hard hangs after it gets this error and has to be 
> powered off in order to reboot it.


I tested 2.2.18-24 with an initrd and works fine on the same hardware, 
BTW

Jeff


> 
> Jeff 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
