Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318161AbSHIGLK>; Fri, 9 Aug 2002 02:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318162AbSHIGLK>; Fri, 9 Aug 2002 02:11:10 -0400
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:42678 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S318161AbSHIGLK>; Fri, 9 Aug 2002 02:11:10 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roberto Gordo Saez <rgs@linalco.com>, <linux-kernel@vger.kernel.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH] GMAC ethernet controller (Apple PowerPC)
Date: Fri, 9 Aug 2002 08:14:07 +0200
Message-Id: <20020809061407.6599@smtp.wanadoo.fr>
In-Reply-To: <20020808100402.GA7953@filemon>
References: <20020808100402.GA7953@filemon>
X-Mailer: CTM PowerMail 3.1.2 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Small fix for the link status (carrier) on PowerPC GMAC net driver.
>
>Now ifconfig reports correctly the "RUNNING" flag, the same way that it
>is reported with other network cards i've tested (intel eepro100 on i386).

Thanks. However, the gmac driver is obsolete now (and will be removed
from 2.5), you should really use sungem instead.

Ben.


