Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262728AbVCPSb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262728AbVCPSb6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 13:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbVCPSb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 13:31:58 -0500
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:52618 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S262728AbVCPSb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 13:31:56 -0500
Message-Id: <200503161824.j2GIOArr007631@ginger.cmf.nrl.navy.mil>
To: Adrian Bunk <bunk@stusta.de>
cc: shemminger@osdl.org, bridge@osdl.org,
       linux-atm-general@lists.sourceforge.net, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Reply-To: chas3@users.sourceforge.net
Reply-To: chas3@users.sourceforge.net
Reply-To: chas3@users.sourceforge.net
Subject: Re: [2.6 patch] fix bridge <-> ATM compile error 
In-reply-to: <20050316181532.GA3251@stusta.de> 
Date: Wed, 16 Mar 2005 13:24:11 -0500
From: "chas williams - CONTRACTOR" <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20050316181532.GA3251@stusta.de>,Adrian Bunk writes:
>Letting CONFIG_BRIDGE depend on CONFIG_ATM doesn't sound like a good 
>idea, since I doubt all people using the Bridge code require ATM 
>support.

i agree.

>Moving the hooks to the bridge code will give you exactly the same 
>problems the other way round.

how about moving them to a third location like net/core/dev.c?
