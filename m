Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261801AbTCQRV2>; Mon, 17 Mar 2003 12:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261802AbTCQRV2>; Mon, 17 Mar 2003 12:21:28 -0500
Received: from janus.zeusinc.com ([205.242.242.161]:62572 "EHLO
	zso-proxy.zeusinc.com") by vger.kernel.org with ESMTP
	id <S261801AbTCQRV1>; Mon, 17 Mar 2003 12:21:27 -0500
Subject: 2.5.64-mm8 breaks MASQ
From: Tom Sightler <ttsig@tuxyturvy.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1047922184.3223.2.camel@iso-8590-lx.zeusinc.com>
Mime-Version: 1.0
Date: 17 Mar 2003 12:29:45 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been attempting to test the -mm kernels.  I was having problems
with the anticipatory scheduler up causing the machine to hang during
loading of the USB driver.  The recent fixes that went into -mm8 seem to
have corrected this problem, unfortunately I'm now hitting another
issue.

It seems that -mm8 breaks MASQ support in iptables.  Actually I can't
get any MASQ/NAT to work at all.  The same exact config works fine with
vanilla 2.5.64 and 2.5.64-ac4.

Backing out the brlock patches returns everything to normal operation so
there's something happening with those.  I'll try to look at them
individually if I get a chance but I know practically nothing about that
code so somebody will probably spot a problem quicker.

Later,
Tom


