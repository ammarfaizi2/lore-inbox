Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbUK2Msq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbUK2Msq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 07:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbUK2MrC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 07:47:02 -0500
Received: from canuck.infradead.org ([205.233.218.70]:15878 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261694AbUK2Mpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 07:45:30 -0500
Subject: Re: [lkdump-develop] Re: [ANNOUNCE 0/7] Diskdump 1.0 Release
From: Arjan van de Ven <arjan@infradead.org>
To: Takao Indoh <indou.takao@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, lkdump-develop@lists.sourceforge.net
In-Reply-To: <42C4D60FC636FDindou.takao@jp.fujitsu.com>
References: <1101727191.2814.52.camel@laptop.fenrus.org>
	 <42C4D60FC636FDindou.takao@jp.fujitsu.com>
Content-Type: text/plain
Message-Id: <1101732313.2814.63.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Mon, 29 Nov 2004 13:45:13 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-29 at 21:34 +0900, Takao Indoh wrote:
> The problem of kexec-dump is that initialization of devices depends
> on the quality of device driver when kexec reboots system. Sometimes the
> device drivers tacitly rely on the firmware to initialize them.

thankfully linux has very very few of those nowadays...

> 
> Anyway, most important point is that kexec-dump is not available enough
> now. 

How is that ?
>
> I think kexec-dump is not stable yet. 

Do you have any facts to back this up? Is your project more stable ?
What is the success rate of dumps of diskdump ? How does that compare to
kexec-dump under the same circumstances ?

> I heard that kexec-dump of
> some architecture (ex. ia64) had some problems and not worked.

wouldn't it be better to then help finish that rather than making an
alternative ? 


