Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264294AbTHVTeU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 15:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264300AbTHVTeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 15:34:20 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:46488 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S264294AbTHVTeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 15:34:18 -0400
Message-Id: <200308221934.h7MJYDsG007334@ginger.cmf.nrl.navy.mil>
To: Francois Romieu <romieu@fr.zoreil.com>
cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [PATCH 3/8] 2.6.0-test2-bk8 - seq_file conversion of /proc/net/atm (pvc) 
In-Reply-To: Message from Francois Romieu <romieu@fr.zoreil.com> 
   of "Sat, 09 Aug 2003 00:10:13 +0200." <20030809001013.D2699@electric-eye.fr.zoreil.com> 
Date: Fri, 22 Aug 2003 15:34:14 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: (*) hits=1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030809001013.D2699@electric-eye.fr.zoreil.com>,Francois Romieu wr
ites:
>seq_file support for /proc/net/atm/pvc:
>- pvc_info(): seq_printf/seq_putc replaces sprintf;
>- atm_pvc_info() removal;
>- the vc helpers (atm_vc_common_seq_xxx) do the remaining work.

again, suggest renaming atm_pvc_XXXX to just pvc_XXXX
atm_seq_pvc_fops should probably be pvc_seq_fops.
