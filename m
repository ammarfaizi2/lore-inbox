Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbUKUQUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbUKUQUS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 11:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbUKUQQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 11:16:45 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:7834 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261181AbUKUQP4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 11:15:56 -0500
Date: Sun, 21 Nov 2004 17:15:12 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: cranium2003 <cranium2003@yahoo.com>
cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, netdev@oss.sgi.com
Subject: Re: how netfilter handles fragmented packets
In-Reply-To: <20041121153154.85910.qmail@web41403.mail.yahoo.com>
Message-ID: <Pine.LNX.4.53.0411211714530.18608@yvahk01.tjqt.qr>
References: <20041121153154.85910.qmail@web41403.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>hello,
>          In ip_output.c file ip_fragmet function when
>create a new fragmented packet given to output(skb)
>function. i want to know which function are actually
>called by output(skb)?

use stack_dump() (or was it dump_stack()?)



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
