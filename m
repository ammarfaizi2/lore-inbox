Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271266AbTHHGeK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 02:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271272AbTHHGeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 02:34:10 -0400
Received: from ip-86-245.evc.net ([212.95.86.245]:13715 "EHLO hal9003.1g6.biz")
	by vger.kernel.org with ESMTP id S271266AbTHHGeG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 02:34:06 -0400
From: "Nicolas P." <linux@1g6.biz>
To: William Enck <wenck@wapu.org>, linux-kernel@vger.kernel.org
Subject: Re: orinoco_cs: RequestIRQ: Unsupported mode
Date: Fri, 8 Aug 2003 08:31:22 +0200
User-Agent: KMail/1.5
Cc: David Gibson <hermes@gibson.dropbear.id.au>
References: <20030808031706.GB20401@chaos.byteworld.com>
In-Reply-To: <20030808031706.GB20401@chaos.byteworld.com>
Organization: 1G6
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308080831.22218.linux@1g6.biz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Forgot my last mail, I checked

it was : orinoco_cs: RequestIRQ: Resource in use

Nicolas.


Le Vendredi 8 Août 2003 05:17, William Enck a écrit :
> dmesg outputs the following
>
> orinoco_cs.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
> orinoco_cs: RequestIRQ: Unsupported mode
>
> It does that in 2.6.0-test2-(bk7|bk7-netdrvr1|mm5).
>
> It functions correctly in 2.6.0-test2 and -mm4.
>
> Attached is my config for 2.6.0-test2-mm5 as well as mm4-mm5_config.diff
> which is a diff -u on the two .config's used.
>
> Also, I just noticed that dmesg produces:
> orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
> orinoco_cs: Unknown parameter `8200'
>
> But it is in the dmesg output of both mm4 and mm5
>
> Let me know if anything else is needed to try to figure out what happend
> between -mm4 and -mm5
>
> Will

