Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262667AbVCPQTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262667AbVCPQTZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 11:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262672AbVCPQTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 11:19:25 -0500
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:64901 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S262667AbVCPQTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 11:19:23 -0500
Message-Id: <200503161611.j2GGBT0F004479@ginger.cmf.nrl.navy.mil>
To: Adrian Bunk <bunk@stusta.de>
cc: shemminger@osdl.org, bridge@osdl.org,
       linux-atm-general@lists.sourceforge.net, netdev@oss.sgi.co,
       linux-kernel@vger.kernel.org
Reply-To: chas3@users.sourceforge.net
Reply-To: chas3@users.sourceforge.net
Reply-To: chas3@users.sourceforge.net
Subject: Re: [2.6 patch] fix bridge <-> ATM compile error 
In-reply-to: <20050315121930.GE3189@stusta.de> 
Date: Wed, 16 Mar 2005 11:11:29 -0500
From: "chas williams - CONTRACTOR" <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20050315121930.GE3189@stusta.de>,Adrian Bunk writes:
>This patch fixes the following compile error with CONFIG_BRIDGE=y and 
>CONFIG_ATM_LANE=m:

isnt the problem more that CONFIG_ATM=m not CONFIG_ATM_LANE=m?
perhaps CONFIG_BRIDGE should be dependent on CONFIG_ATM.  if
atm is a module then bridge cannot be a module (unless the 
hooks are moved from atm to bridge)?
