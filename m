Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbULAHc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbULAHc6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 02:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbULAHc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 02:32:58 -0500
Received: from [193.178.151.93] ([193.178.151.93]:30388 "EHLO as.unibanka.lv")
	by vger.kernel.org with ESMTP id S261324AbULAHcz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 02:32:55 -0500
From: Aivils <aivils@unibanka.lv>
Reply-To: aivils@unibanka.lv
Organization: Unibanka
To: linux-kernel@vger.kernel.org, kde-linux@mail.kde.org, post-only@gnome.org,
       xfree86@XFree86.Org, xorg@freedesktop.org
Subject: Multimedia key utilization under Linux. Another implementation.
Date: Wed, 1 Dec 2004 10:31:55 +0300
User-Agent: KMail/1.6.1
Cc: linuxconsole-dev@lists.sourceforge.net, Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200412010931.55053.aivils@unibanka.lv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All!

X - X windows system
K - Linux kernel
E - Events as well

INTRODUCTION
------------

    xke is userspace program which is capable read and recognize Linux
kernel generated events of input devices. xke translate Linux kernel
events and send to X windows system. Main goal is keyboar multimedia key
utilization.
    As input xke uses /dev/input/eventXX device files. As output xke uses
Xtst.so library alias Xtest extension.
    xke uses unified Linux input event system. xke don't care what input
device is connected in the box. From point of view of xke differs only
device name and some parmeters. So xke satisfactory works with keyboard,
mouse and tablet.
    xke can connect to local X server any time when end-user will do it,
because use Xtst library. End-user may start and stop xke during X sesion
and use user specific settings.
    Right now xke maps key press/release events to
generate key (key-press/release) series
launch programs
generate mouse motions
generate button-press/release
    Button press and x y axis motion events will be sended to X "unchanged".

xke is a merge and rewrite from the programs:
evdev XFree86 driver by Zephaniah E. Hull
xkeymouse by Henrik Sandklef
tuntiko XFree86 driver by Daniel Skarda

http://www.ltn.lv/~aivils/files/xke-0.01.tar.bz2

Best regards, Aivils Stoss
