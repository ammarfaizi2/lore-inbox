Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318080AbSHZNLN>; Mon, 26 Aug 2002 09:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318086AbSHZNLN>; Mon, 26 Aug 2002 09:11:13 -0400
Received: from [217.167.51.129] ([217.167.51.129]:58616 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S318080AbSHZNLM>;
	Mon, 26 Aug 2002 09:11:12 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre4-ac2
Date: Mon, 26 Aug 2002 17:15:26 +0200
Message-Id: <20020826151526.3442@192.168.4.1>
In-Reply-To: <200208261035.g7QAZ4G19985@devserv.devel.redhat.com>
References: <200208261035.g7QAZ4G19985@devserv.devel.redhat.com>
X-Mailer: CTM PowerMail 3.1.2 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>o	Fix gmac link status reporting			(Roberto Gordo Saez)

FYI, gmac is now obsolete and is replaced by the sungem
driver.

I'll soon send a patch removing it entirely from the kernel
source tree as there is no case where it works better than
sungem on a given HW.

Ben.

