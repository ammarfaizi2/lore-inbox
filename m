Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271920AbTGYEB4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 00:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271921AbTGYEB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 00:01:56 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:27661 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S271920AbTGYEBz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 00:01:55 -0400
To: junkio@cox.net
Cc: Hiroshi Miura <miura@da-cha.org>, linux-kernel@vger.kernel.org
Subject: Re: Japanese keyboards broken in 2.6
References: <fa.jnbj30u.1g6me0g@ifi.uio.no> <fa.d9tgtm5.1m7agi1@ifi.uio.no>
	<7vy8ynbet0.fsf@assigned-by-dhcp.cox.net>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 25 Jul 2003 13:16:54 +0900
In-Reply-To: <7vy8ynbet0.fsf@assigned-by-dhcp.cox.net>
Message-ID: <87r84fw895.fsf@ibmpc.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you are not interested in using keycode above 255 (e.g. all
> you care about is keycode 183 for Japanese 86/106 keyboard),
> then the patch I sent to the list should be sufficient.

Basically yes. But was the following case solved?

       dumpkeys < ${DEVICE_PREFIX}1 |sed -f /etc/console-tools/remap |loadkeys
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
