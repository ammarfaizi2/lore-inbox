Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265039AbTANS6G>; Tue, 14 Jan 2003 13:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265063AbTANS6G>; Tue, 14 Jan 2003 13:58:06 -0500
Received: from yuha.menta.net ([212.78.128.42]:1207 "EHLO yuha.menta.net")
	by vger.kernel.org with ESMTP id <S265039AbTANS5t>;
	Tue, 14 Jan 2003 13:57:49 -0500
From: Ivanovich <ivanovich@menta.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.58 - bttv broken?
Date: Tue, 14 Jan 2003 20:06:25 -0100
User-Agent: KMail/1.5
Cc: kraxel@bytesex.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200301142006.25592.ivanovich@menta.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just tried my tv card (Miro PCTV) with 2.5.58 and TV output looks very wrong.
It gets drawn outside the xawtv window (displaced to the left, more displaced 
if the window is placed in the right of the screen ?!?), it's B&W instead of 
color, and shows ugly vertical black lines.

It works perfectly with the 2.4.20 drivers.

cat /proc/video/dev/video0
name            : BT878(Pinnacle PCTV Studio/Ra)
type            : 
VID_TYPE_CAPTURE|VID_TYPE_TUNER|VID_TYPE_OVERLAY|VID_TYPE_CLIPPING|VID_TYPE_SCALES
hardware        : 0x1

Tell me if you need more info.
CC me replies plz, i'm not suscribed to lklm.
