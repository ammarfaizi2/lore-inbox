Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261186AbSJYCmw>; Thu, 24 Oct 2002 22:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261191AbSJYCmw>; Thu, 24 Oct 2002 22:42:52 -0400
Received: from uni01du.unity.ncsu.edu ([152.1.13.101]:44172 "EHLO
	uni01du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id <S261186AbSJYCmw>; Thu, 24 Oct 2002 22:42:52 -0400
From: jlnance@unity.ncsu.edu
Date: Thu, 24 Oct 2002 22:49:06 -0400
To: linux-kernel@vger.kernel.org
Subject: USB does not work after 2.4.18 to 2.5.44-ac2 upgrade
Message-ID: <20021025024906.GA18214@ncsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
    I decided to do what Linus asked, and try out a 2.5.X kernel.
The machine boots fine with the 2.5.44-ac2 kernel I installed, however
I am having some problems with USB.  The usb-uhci module seems to be
gone.  I read Documentation/usb/uhci.txt and it appears that the
uhci module has been rewritten.  I assume the module named uhci-hcd.o
is the replacement, but I could not find that written down anywhere.
I did an insmod of this module and I can now see the hub in
/proc/bus/usb/devices.  I dont see any of my other USB devices in that
file, even after I insmod the drivers.  Does anyone know what I need to
do to make this all work, preferably in a way that will let me boot into
a 2.4 kernel as well?

Thanks,

Jim
