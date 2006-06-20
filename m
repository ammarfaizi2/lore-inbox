Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbWFTVOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWFTVOS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 17:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWFTVOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 17:14:18 -0400
Received: from secure.htb.at ([195.69.104.11]:38159 "EHLO pop3.htb.at")
	by vger.kernel.org with ESMTP id S1751084AbWFTVOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 17:14:17 -0400
Date: Tue, 20 Jun 2006 23:14:08 +0200
From: Richard Mittendorfer <delist@gmx.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: bootmsg: unable to open rtc device (rtc0)
Message-Id: <20060620231408.c8c8120b.delist@gmx.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i486-pc-linux-gnu)
X-Face: &0P^N,K:@}b8ykW@3d!=n}3D;*Cf{9KYT>>+gcM)XyIMRkBSDg|ur7Zen^BlzmJVr&!;7KT6\
 t+sHI69\fW(}.=PM+(`w_jnzZ.HbWb/KM"`795_k(&\Lje|'g\cm$4e%Zy*I)hJz-z0!}xkm@!>U0rO{>
 ~[YZUs/=B{}R%#nZ8eBt'{,*>kTTKl_kj'vzrl5|'j5SBiFy#!Sj,p_zl;)q.lpSI\Er"]D`bZY@#+']k
 JW/YsqvRzi0GR!7ifpt$?]0TYcNs.*wC5OukokPm~R&mmW\q&DL@='khZEET;3ryo[0_mC^K~7,ZvHkj
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *1FsnY1-00062Q-00*xe39cRneQlM*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hoi LKML,

I get this dmesg-message on all my lately build kernels:

...
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
...

.config:
CONFIG_RTC=y
CONFIG_RTC_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"

I tried "rtc" also, as i do have /dev/rtc (but no /dev/rtc0). Maybe I
schould give it the full path?

sl ritch
