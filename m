Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261953AbVG1V7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbVG1V7h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 17:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbVG1V7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 17:59:37 -0400
Received: from mail.gmx.de ([213.165.64.20]:42472 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261953AbVG1V7c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 17:59:32 -0400
X-Authenticated: #1347008
Message-ID: <42E9560A.6080205@gmx.net>
Date: Fri, 29 Jul 2005 00:02:50 +0200
From: Dirk <noisyb@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Thonke <iogl64nx@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm3
References: <20050728025840.0596b9cb.akpm@osdl.org> <42E96A42.7060405@gmail.com>
In-Reply-To: <42E96A42.7060405@gmail.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Thonke wrote:

> Hello Andrew,
>
> here again I have two problems. With 2.6.13-rc3-mm3 I have problems
> using my SATA drives on Intel ICH6.
> The kernel can't route there IRQs or can't discover them. the option
> irqpoll got them to work now.
> The problem is new because 2.6.13-rc3[-mm1,mm2] work without any
> problems.
>
> The SATA drives are Samsung HD160JJ SATAII. The mainboard I use is a
> ASUS P4GPL-X.
>
> Second one is about Intel HD-Codec (snd-hda-intel) on modprobe when
> loading the module it gives me
>
> ---> snip
> hda_codec: Unknown model for ALC880, trying auto-probe from BIOS...
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000000


Hi!
Sorry for interfering but I have the Asus P5RD1-VD with the Realtek
ALC861 (10b9:5461) and with 2.6.13.3 I've got the problem that he
doesn't find /dev/mixer or anything after modprobe snd-hda-intel...

After I attached
http://dlsvr01.asus.com/pub/ASUS/mb/socket775/P5RD1-V/Audio_Linux.zip
(which doesn't work) to a mail in alsa-devel they told me...

"[...]

It tries to access the ALi controller in the same way as the Intel
controller.

It may be possible that the ALi chip was designed to be compatible
with Intel's, but that they got some detail wrong.  Or that the driver
gets some detail wrong.  There's no way to know without docs[...]"

(not in the archive, yet...)


Dirk


