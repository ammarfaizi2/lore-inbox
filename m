Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271386AbTG2KCg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 06:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271389AbTG2KCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 06:02:36 -0400
Received: from mail.convergence.de ([212.84.236.4]:18144 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S271386AbTG2KCf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 06:02:35 -0400
Message-ID: <3F264638.7000006@convergence.de>
Date: Tue, 29 Jul 2003 12:02:32 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4) Gecko/20030715
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, torvalds@osdl.org
Subject: Re: [PATCH 1/6] [DVB] Kconfig and Makefile updates
References: <10594710302828@convergence.de> <Pine.LNX.4.44.0307291153340.717-100000@serv>
In-Reply-To: <Pine.LNX.4.44.0307291153340.717-100000@serv>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Roman,

> You can change this also into:
> 
> config VIDEO_SAA7146
> 	def_tristate DVB_AV7110 || DVB_BUDGET || DVB_BUDGET_AV || \
> 		     VIDEO_MXB || VIDEO_DPC || VIDEO_HEXIUM_ORION || \
> 		     VIDEO_HEXIUM_GEMINI
> 	depends on VIDEO_DEV && PCI && I2C

Thanks! I've submitted it to our CVS, it will be in the next patchset.

> bye, Roman

CU
Michael.

