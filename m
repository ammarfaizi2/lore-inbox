Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbVECSRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbVECSRk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 14:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVECSOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 14:14:01 -0400
Received: from fire.osdl.org ([65.172.181.4]:59096 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261503AbVECSLt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 14:11:49 -0400
Date: Tue, 3 May 2005 11:11:35 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] PAL-M support fix for CX88 chipsets - final version
 :-)
Message-Id: <20050503111135.108fcc00.rddunlap@osdl.org>
In-Reply-To: <4277BD33.30009@brturbo.com.br>
References: <42777318.2070508@brturbo.com.br>
	<20050503083822.68a116d4.rddunlap@osdl.org>
	<4277B833.9020109@brturbo.com.br>
	<20050503105202.42fa5ffb.rddunlap@osdl.org>
	<4277BD33.30009@brturbo.com.br>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: SvC&!/v_Hr`MvpQ*|}uez16KH[#EmO2Tn~(r-y+&Jb}?Zhn}c:Eee&zq`cMb_[5`tT(22ms
 (.P84,bq_GBdk@Kgplnrbj;Y`9IF`Q4;Iys|#3\?*[:ixU(UR.7qJT665DxUP%K}kC0j5,UI+"y-Sw
 mn?l6JGvyI^f~2sSJ8vd7s[/CDY]apD`a;s1Wf)K[,.|-yOLmBl0<axLBACB5o^ZAs#&m?e""k/2vP
 E#eG?=1oJ6}suhI%5o#svQ(LvGa=r
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 May 2005 15:04:35 -0300 Mauro Carvalho Chehab wrote:

| This patch fixes PAL-M chroma subcarrier frequency (FSC) to its correct 
| value of 3.5756115 MHz and adjusts horizontal total samples for PAL-M, 
| according with formula Line Draw Time / (4*FSC).
| 
| Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>


+	if (V4L2_STD_PAL_M  & norm->id)
still has 2 spaces after _M, but it's not a big deal.

Now who will merge it?


Thanks.
---
~Randy
