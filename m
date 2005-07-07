Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVGGIeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVGGIeJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 04:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVGGIbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 04:31:51 -0400
Received: from cartier.jerryweb.org ([80.68.90.16]:58383 "EHLO
	cartier.jerryweb.org") by vger.kernel.org with ESMTP
	id S261259AbVGGIbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 04:31:09 -0400
Message-ID: <1120725073.42cce85173364@webmail.jerryweb.org>
Date: Thu, 07 Jul 2005 09:31:13 +0100
From: Jeremy Laine <jeremy.laine@polytechnique.org>
To: 7eggert@gmx.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS: frequent crashes with bttv in 2.6.X series (inc. 2.6.12)
References: <4njei-1Ps-21@gated-at.bofh.it> <E1DqJ1b-0001Li-0t@be1.7eggert.dyndns.org>
In-Reply-To: <E1DqJ1b-0001Li-0t@be1.7eggert.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.6
X-Originating-IP: 195.115.41.103
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Heavy HDD IO almost certainly caused soon death (recognizable by heavy
> picture distortion), while an idle system lasted one evening. It did not
> happen with kernel 2.4 and a NVidia card on XF86.

You are very probably onto something there, the latest OOPS I sent (the 2AM one)
occurred while my daily backup script was running!

Jul  7 02:10:01 sharky /USR/SBIN/CRON[6656]: (root) CMD
(/home/save/bin/mount-wrapper bkp-section -c daily)
Jul  7 02:10:08 sharky kernel: EXT3 FS on dm-2, internal journal
Jul  7 02:11:36 sharky kernel: Unable to handle kernel paging request at virtual
address 1400000c

Kind regards,
Jeremy

-- 
http://www.jerryweb.org/             : JerryWeb.org
http://sailcut.sourceforge.net/      : Sailcut CAD
http://opensource.polytechnique.org/ : Polytechnique.org Free Software
