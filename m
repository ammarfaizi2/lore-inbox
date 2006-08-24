Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030270AbWHXEHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbWHXEHR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 00:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbWHXEHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 00:07:17 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:11287 "EHLO
	asav02.insightbb.com") by vger.kernel.org with ESMTP
	id S1030270AbWHXEHQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 00:07:16 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AR4FAATC7ESBUA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Greg KH <gregkh@suse.de>
Subject: [GIT PULL] Input updates for 2.6.18
Date: Thu, 24 Aug 2006 00:07:14 -0400
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608240007.14625.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please pull from:

        git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

or
        master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git for-linus

It has several updates to the input subsystem:

Alexey Dobriyan:
      Input: remove dead URLs from Doclumentation/input/joystick.txt

Dmitry Torokhov:
      Input: wistron - fix crash due to referencing __initdata

Florin Malita:
      Input: atkbd - fix overrun in atkbd_set_repeat_rate()

Pozsar Balazs:
      Input: psmouse - fix Intellimouse 4.0 initialization


 Documentation/input/joystick.txt   |    1 -
 drivers/input/keyboard/atkbd.c     |    2 +-
 drivers/input/misc/wistron_btns.c  |   16 ++++++++--------
 drivers/input/mouse/psmouse-base.c |    7 -------
 4 files changed, 9 insertions(+), 17 deletions(-)


-- 
Dmitry
