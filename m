Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278424AbRJ1PI7>; Sun, 28 Oct 2001 10:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278429AbRJ1PIt>; Sun, 28 Oct 2001 10:08:49 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14348 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278424AbRJ1PIf>; Sun, 28 Oct 2001 10:08:35 -0500
Subject: Re: [PATCH] linux-2.4.13 - i8xx series chipsets patches
To: wim@iguana.be (Wim Van Sebroeck)
Date: Sun, 28 Oct 2001 15:15:41 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20011028153419.A24908@medelec.uia.ac.be> from "Wim Van Sebroeck" at Oct 28, 2001 03:34:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15xrf3-00084J-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Why all this renaming and reformatting - what does your patch really do
> > other than generate a lot of pointless noise
> 
> Sorry to upset you for this reformatting. What I did was look at the I/O Controller Hub of the intel 8xx series of chipsets and had a look what was supported and what was not. The 82801CA and 82801CAM I/O Controller Hubs were not supported yet and thus I added support for this in the IDE code, the watchdog timer and the random number generator. These Hubs will support intel 830 and intel 830MP (and probably others in the future as well) series of motherboards. 
> My main source of info was the datasheets from intel on the different 82801 chips.

Can you send me this as two seperate patches then. Firstly a patch which
just updates the naming because our existing naming is wrong (if its
actually wrong rather than just differet)

Secondly a patch which just adds the ones we are missing

Thanks

Alan
