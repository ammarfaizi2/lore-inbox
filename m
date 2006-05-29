Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWE2Fqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWE2Fqd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 01:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWE2Fqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 01:46:33 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:62886
	"EHLO sunset.sfo1.dsl.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751208AbWE2Fqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 01:46:32 -0400
Date: Sun, 28 May 2006 22:46:51 -0700 (PDT)
Message-Id: <20060528.224651.122944838.davem@davemloft.net>
To: dev@opensound.com
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org, bidulock@openss7.org,
       rlrevell@joe-job.com, heiko.carstens@de.ibm.com
Subject: Re: How to check if kernel sources are installed on a system?
From: David Miller <davem@davemloft.net>
In-Reply-To: <447A883C.5070604@opensound.com>
References: <20060528224402.A13279@openss7.org>
	<1148878368.3291.40.camel@laptopd505.fenrus.org>
	<447A883C.5070604@opensound.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: 4Front Technologies <dev@opensound.com>
Date: Sun, 28 May 2006 22:35:56 -0700

> BTW, why is Mandriva the only distro to turn OFF REGPARM?. Again, I
> think distros shouldn't be given an option to turn it off if its a
> good thing to have.  Are there any good reasons why REGPARM is
> turned off?.

Each distribution has different demands and timing regarding the
relase of their compiler relative to the release of the kernel source
they decide to use.

It may have been prudent to fix a REGPARM miscompilation of the kernel
by just disabling it for their release.

