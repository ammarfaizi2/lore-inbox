Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311523AbSDIUtr>; Tue, 9 Apr 2002 16:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311536AbSDIUtq>; Tue, 9 Apr 2002 16:49:46 -0400
Received: from coltrane.siteprotect.com ([64.26.16.13]:16621 "EHLO
	coltrane.siteprotect.com") by vger.kernel.org with ESMTP
	id <S311523AbSDIUtp>; Tue, 9 Apr 2002 16:49:45 -0400
From: "Rob Hall" <rob@compuplusonline.com>
To: "Greg KH" <greg@kroah.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: RE: 2.5.7,8-pre2 and USB
Date: Tue, 9 Apr 2002 16:58:30 -0400
Message-ID: <BBENIHKKLAMLHIECFJEPMEPKCAAA.rob@compuplusonline.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20020409133710.A21829@kroah.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was previously running the 2.4.18 kernel... This is the first devel kernel
I have installed since 2.3.x :) I've noticed that according to dmesg, 2.4.x
inits USB MUCH later in the boot sequence than 2.5.7 and 8-pre2 do.

Thanks
--
Rob Hall

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Greg KH
Sent: Tuesday, April 09, 2002 4:37 PM
To: Rob Hall
Cc: linux-kernel
Subject: Re: 2.5.7,8-pre2 and USB


On Tue, Apr 09, 2002 at 02:00:31PM -0400, Rob Hall wrote:
> Hi all,
> 	I'm running a Tyan Tiger Dual Athlon motherboard(S2624). This board has
an
> OHCI USB host controller on-board... I recently compiled 2.5.7, only to
find
> that the machine halts as soon as the USB HC is detected. Same problem
arose
> with 2.5.8-pre2.. Has the location of the USB init been changed? If I
> recompile the kernel with USB support as modules, and load the appropriate
> modules via init script, it works perfectly. Just wondering if this has
been
> reported by anyone else, and if it is a known issue, what is the cause and
> is there a patch yet?

Which previous kernel did compiling the usb-ohci driver into the kernel
successfully
work for you?

thanks,

greg k-h
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


