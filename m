Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbVF1OSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVF1OSv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 10:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbVF1OQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 10:16:57 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:49345 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261465AbVF1OM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 10:12:26 -0400
Message-ID: <42C15AAB.5070101@jp.fujitsu.com>
Date: Tue, 28 Jun 2005 23:11:55 +0900
From: Naoaki Maeda <maeda.naoaki@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: sekharan@us.ibm.com
CC: Gerrit Huizenga <gh@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net,
       Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [ckrm-tech] [patch 25/38] CKRM e18: Add fork rate control to
 the numtasks controller
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com>	 <20050623061759.325157000@w-gerrit.beaverton.ibm.com>	 <42BFA5C6.9040604@jp.fujitsu.com> <1119899131.14910.18.camel@linuxchandra>
In-Reply-To: <1119899131.14910.18.camel@linuxchandra>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chandra,

Chandra Seetharaman wrote:

> It is not a limit, it is the system level number of tasks assumed by the
> numtasks controller, so, it cannot be a _no limit_, it has to be real
> number.

If the magic numner 131072 is not hard coded in the numtask source code
and copied from the kernel parameter in runtime, it makes sense.
But, copying magic number is ugly.

Thanks,
MAEDA Naoaki

