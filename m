Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbUDLT3O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 15:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263033AbUDLT3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 15:29:14 -0400
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107]:18695 "EHLO
	sampa7.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S263040AbUDLT3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 15:29:12 -0400
Date: Mon, 12 Apr 2004 16:27:45 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: ajapted@netspace.net.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] v2.6.5 drivers/video/console/mdacon.c
Message-Id: <20040412162745.60c51705.lcapitulino@prefeitura.sp.gov.br>
In-Reply-To: <20040412211706.E30061@infomag.infomag.iguana.be>
References: <20040412211706.E30061@infomag.infomag.iguana.be>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Wim,

Em Mon, 12 Apr 2004 21:17:06 +0200
Wim Van Sebroeck <wim@iguana.be> escreveu:

| -static int mdacon_blank(struct vc_data *c, int blank)
| +static int mdacon_blank(struct vc_data *c, int blank, int mode_switch)
|  {
|  	if (mda_type == TYPE_MDA) {
|  		if (blank) 

 I already fixed this one.

-- 
Luiz Fernando N. Capitulino
<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>
