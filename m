Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262539AbTJTLMa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 07:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbTJTLMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 07:12:30 -0400
Received: from zeus.kernel.org ([204.152.189.113]:38359 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262539AbTJTLM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 07:12:28 -0400
Date: Mon, 20 Oct 2003 12:33:24 +0200 (MEST)
From: Javier Achirica <achirica@telefonica.net>
To: Joseph Pingenot <trelane@digitasaru.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: airo regression with Linux 2.4.23-pre2
In-Reply-To: <20031019151943.GA3528@digitasaru.net>
Message-ID: <Pine.SOL.4.30.0310201230550.742-100000@tudela.mad.ttd.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 19 Oct 2003, Joseph Pingenot wrote:

> When inserting the airo card in kernel 2.4.22 and 2.4.22-bk36, I get the
>   following error:
>
> Oct 18 16:50:10 paulus cardmgr[3036]: socket 1: 350 Series Wireless LAN Adapter
> Oct 18 16:50:11 paulus airo: register interrupt 0 failed, rc -16
> Oct 18 16:50:11 paulus airo_cs: RequestConfiguration: Operation succeeded
> Oct 18 16:50:12 paulus cardmgr[3036]: get dev info on socket 1 failed: Resource temporarily unavailable
>
> Do you know where this might be coming from?  The card works pretty well
>   (it actually has the following problem in 2.4.21:

I had that problem with some versions of the ACPI PCI interrrupt routing
code. Disabling it fixes the bug.

> (unfortunately, it doesn't look like ksymoops could translate this for
>   some reason.)
>
> which is what I was hoping was fixed in the upgrade.

This bug is fixed (hopefully :-)

Javier Achirica

