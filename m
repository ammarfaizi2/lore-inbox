Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbTFYG7l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 02:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262976AbTFYG7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 02:59:40 -0400
Received: from [62.29.72.68] ([62.29.72.68]:49024 "EHLO submoron.org")
	by vger.kernel.org with ESMTP id S262623AbTFYG7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 02:59:38 -0400
From: "ismail (cartman) donmez" <kde@myrealbox.com>
Organization: Bogazici University
To: Valdis.Kletnieks@vt.edu
Subject: Re: Weird modem behaviour in 2.5.73-mm1
Date: Wed, 25 Jun 2003 10:13:51 +0300
User-Agent: KMail/1.5.9
References: <200306242102.49356.kde@myrealbox.com> <200306250327.h5P3RwH8001577@turing-police.cc.vt.edu>
In-Reply-To: <200306250327.h5P3RwH8001577@turing-police.cc.vt.edu>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
   =?ISO-8859-1?Q?=20charset=3D=22=FDso-885?= =?ISO-8859-1?Q?9-1=22?=
Content-Transfer-Encoding: 7bit
Message-Id: <200306251013.51828.kde@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 June 2003 06:27, you wrote:
> 2.5.73-mm1 threw this all 3 times I tried starting PPPD:
>
> Jun 24 22:37:48 turing-police pppd[1144]: Using interface ppp0
> Jun 24 22:37:48 turing-police pppd[1144]: Connect: ppp0 <--> /dev/ttyS14
> Jun 24 22:37:49 turing-police pppd[1144]: sent [LCP ConfReq id=0x1
> <asyncmap 0x0> <magic 0x9ed88e38> <pcomp> <accomp>] Jun 24 22:37:49
> turing-police pppd[1144]: Modem hangup
> Jun 24 22:37:49 turing-police pppd[1144]: Connection terminated.
>

Yes same messages.

> i.e. it died a quick and horrid death.  I've not checked a plain 2.5.73
> yet, but I suspect this is the most likely culprit:
>
> #	           ChangeSet	1.1348.1.42 -> 1.1348.1.43
> #	 drivers/net/pppoe.c	1.31    -> 1.32
> #	drivers/net/ppp_generic.c	1.33    -> 1.34
> #
> # The following is the BitKeeper ChangeSet Log
> # --------------------------------------------
> # 03/06/23	shemminger@osdl.org	1.1348.1.43
> # [NET]: Convert PPPoE to new style protocol.
> # --------------------------------------------
>

Nice hope its fixed in -mm2

Regards,
/ismail
