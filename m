Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbVCORUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVCORUJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 12:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVCORSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 12:18:45 -0500
Received: from fire.osdl.org ([65.172.181.4]:26517 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261610AbVCORQS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 12:16:18 -0500
Date: Tue, 15 Mar 2005 09:13:05 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: bridge@osdl.org, chas@cmf.nrl.navy.mil,
       linux-atm-general@lists.sourceforge.net, netdev@oss.sgi.co,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fix bridge <-> ATM compile error
Message-ID: <20050315091305.3fc07561@dxpl.pdx.osdl.net>
In-Reply-To: <20050315121930.GE3189@stusta.de>
References: <20050315121930.GE3189@stusta.de>
Organization: Open Source Development Lab
X-Mailer: Sylpheed-Claws 1.0.1 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Given the #ifdef mess, perhaps bridge should have the hooks available
independent of the configuration.
