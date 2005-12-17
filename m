Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbVLQAan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbVLQAan (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 19:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbVLQAan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 19:30:43 -0500
Received: from main.gmane.org ([80.91.229.2]:46057 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932560AbVLQAam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 19:30:42 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>
Subject: Re: gtkpod and Filesystem
Followup-To: gmane.linux.kernel
Date: Sat, 17 Dec 2005 01:26:09 +0100
Message-ID: <dnvlut$5rm$2@sea.gmane.org>
References: <20051216145234.M78009@linuxwireless.org> <dnul89$r4k$1@sea.gmane.org> <Pine.LNX.4.61.0512162311180.24996@yvahk01.tjqt.qr> <dnveja$i7i$1@sea.gmane.org> <Pine.LNX.4.61.0512162329320.24996@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 212.117.85.179
User-Agent: KNode/0.10
Cc: debian-devel@lists.debian.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>Mh, what's "more gracefully" in the light of fs corruption?
> return -EIO;

In this case you wouldn't even be able to read data from the disk which is
not affected by the inconsistencies. If the FS driver switches to readonly
mode, that's possible at least. Personally I like such a kind of "Best
effort" behaviour. Well, but I'm not the vfat32 driver developer, so who am
I to argue? :-)

Greetings,

  Gunter

