Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbUKRQhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbUKRQhY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 11:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbUKRQhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 11:37:24 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:2715 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261867AbUKRQhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 11:37:13 -0500
Date: Thu, 18 Nov 2004 17:37:11 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux-kernel@vger.kernel.org
Subject: local packets not in prerouting
Message-ID: <Pine.LNX.4.53.0411181729350.12660@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


I have been observing that locally generated packets with a local destination
have they don't pop up in the nat/PREROUTING chain.
Anybody know why this is done? (If not, it's a bug.)


As a side observation, those packets have source ip == destination ip, so if I
telnet to '127.0.0.44', a LOG target says SRC=127.0.0.44 and DST=127.0.0.44.
Should not be SRC always be 127.0.0.1?



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
