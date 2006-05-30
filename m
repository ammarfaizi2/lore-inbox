Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751466AbWE3ELr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbWE3ELr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 00:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWE3ELq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 00:11:46 -0400
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:9337 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751466AbWE3ELq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 00:11:46 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [git pull] Input update for 2.6.17-rc5
Date: Tue, 30 May 2006 00:11:43 -0400
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200605300011.43803.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull from:

        git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git

or
        master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git

The tree contains fix for memory leak in sidewinder driver, additional
DMI entries for lifebook and wistron drivers, alps old protocol fix
and a couple of other changes.

Diffstat:

 drivers/input/joystick/sidewinder.c |   11 ++++++-----
 drivers/input/keyboard/corgikbd.c   |   12 ++++++------
 drivers/input/keyboard/spitzkbd.c   |   12 ++++++------
 drivers/input/misc/wistron_btns.c   |   19 +++++++++++++++++++
 drivers/input/mouse/alps.c          |    4 ++--
 drivers/input/mouse/lifebook.c      |   24 ++++++++++++++++++++++++
 drivers/input/mouse/logips2pp.c     |    6 ++++++
 include/linux/input.h               |   13 +++++--------
 8 files changed, 74 insertions(+), 27 deletions(-)

Changelog:

Jesper Juhl:
      Input: sidewinder - fix memory leak

Kenan Esau:
      Input: psmouse - DMI updates for lifebook protocol

masc@theaterzentrum.at:
      Input: wistron - add support for AOpen Barebook 1559as

Matthew Garrett:
      Input: add KEY_BATTERY keycode

Richard Purdie:
      Input: change from numbered to named switches

Yotam Medini:
      Input: alps - fix old protocol decoding

Zbigniew Luszpinski:
      Input: psmouse - add detection of Logitech TrackMan Wheel trackball

-- 
Dmitry
