Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbTLUOoc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 09:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbTLUOoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 09:44:32 -0500
Received: from mail01.solnet.ch ([212.101.4.135]:11783 "EHLO mail01.solnet.ch")
	by vger.kernel.org with ESMTP id S261735AbTLUOoa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 09:44:30 -0500
From: "Per Jessen" <per@computer.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Sun, 21 Dec 2003 15:44:27 +0100
X-Mailer: PMMail 2000 Professional (2.20.2717) For Windows 2000 (5.0.2195;4)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: make menuconfig loops ??
Message-Id: <20031221144427.57D00DAA81@mail.local.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  
I have a problem when trying to build a kernel. It appears that make menuconfig
starts to loop - 
after writing "Preparing scripts: functions, parsing ...done."
This is 2.4.23, jfs114, gcc3.3.2.
  
What stuns me is - on this system I have *already* successfully built
2.4.23, and it is running just fine. This second build is for a different
target system, and the sourcetree is (obviously) in a different directory. 
  
1. /usr/src/linux  -> /usr/src/linux-2.4.23  - no problems.    /dev/hda1
2. /data1/linux  ->   /data1/linux-2.4.23 - loops.             /dev/hda4
  
Filesystem in both cases is JFS. 
  
Unpack a vanilla kernel into eg. /data1/kk23/linux-2.4.23 and trying it
there - same result. 
  
I haven't touched or replaced or done anything to ncurses, and lxdialog is
new/rebuilt.
I've straced the 'make menuconfig' and it is quite clearly looping. Can
anyone point me in the right direction and help me try to solve this??  
  
  
thanks,
Per Jessen, Zurich
http://www.dansklisten.org



