Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271137AbRHTJic>; Mon, 20 Aug 2001 05:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271144AbRHTJiX>; Mon, 20 Aug 2001 05:38:23 -0400
Received: from mout1.freenet.de ([194.97.50.132]:27346 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S271137AbRHTJiE>;
	Mon, 20 Aug 2001 05:38:04 -0400
Message-ID: <3B80DA50.49F43B10@athlon.maya.org>
Date: Mon, 20 Aug 2001 11:37:21 +0200
From: Andreas Hartmann <andihartmann@freenet.de>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: [2.4.8-ac5 and earlier] fatal mount-problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,


If you mount a device like ide-cdrom with the scsi-emulation turned on
(as modules) and you do the same mount again on the same (not unmounted)
device, the mount-programm hangs up and never comes back. It doesn't
recognize, that the device is allready mounted.

If I do a simple "mount", mount lists the /cdrom - device as mounted.

Problem: if you want to unmount the device, mount tells that the device
would be bussy and ends. So, you've no chance to unmount the device
again. The only way to unmount it, is to do a hardware reset (a normal
reboot doesn't work, because mount hangs at the cdrom-device).

Kernel 2.4.9 is working fine.

> mount --version
mount: mount-2.11h


Regards,
Andreas Hartmann
