Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266078AbTAPKSo>; Thu, 16 Jan 2003 05:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266081AbTAPKSo>; Thu, 16 Jan 2003 05:18:44 -0500
Received: from pollux.et6.tu-harburg.de ([134.28.85.242]:9927 "EHLO
	mail.et6.tu-harburg.de") by vger.kernel.org with ESMTP
	id <S266078AbTAPKSn>; Thu, 16 Jan 2003 05:18:43 -0500
Subject: Promise SuperTrak SX6000 w/ kernel 2.4.20
From: Sebastian Zimmermann <S.Zimmermann@tu-harburg.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Technical University Hamburg-Harburg
Message-Id: <1042712859.14520.39.camel@antares.et6.tu-harburg.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 16 Jan 2003 11:27:39 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

we are using a Promise SuperTrak RAID controller together with the
integrated i2o-drivers in the linux kernel 2.4.18. Everything works fine
so far.

Now we wanted to upgrade to kernel 2.4.20. Configuration was unchanged.
But now the system hangs at boot time:

When the IDE driver is loaded, it finds the system disk /dev/hda just
like before. But with 2.4.20 the IDE driver also finds disks /dev/hde,
/dev/hdf and so on which belong to the raid system. At this point many
"interrupt lost" messages appear on the screen and the system hangs. It
never gets far enough to load i2o.

Any ideas?

Thanks,

Sebastian

