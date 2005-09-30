Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030267AbVI3LGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbVI3LGv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 07:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbVI3LGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 07:06:50 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:3968 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030267AbVI3LGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 07:06:50 -0400
Subject: Re: RocketPoint 1520 [hpt366] fails clock stabilization
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Loren M. Lang" <lorenl@alzatex.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050930093355.GB22233@alzatex.com>
References: <20050929103309.GA12361@alzatex.com>
	 <1128036611.9290.3.camel@localhost.localdomain>
	 <20050930093355.GB22233@alzatex.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 30 Sep 2005 12:34:04 +0100
Message-Id: <1128080044.17099.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-09-30 at 02:33 -0700, Loren M. Lang wrote:
> I booted FreeBSD 6.0 and it seemed to reconize the card and attached
> hard drive ok.  In the dmesg for freebsd, it mentioned 372N, if that
> means anything.  There is a patch, I discovered, which disables the

Yes - it means its the older card with a 372N on it.

> seg faulting when it failed to detect my chip, and I disabled a check
> for the 372N chipset.

Which means you are misclocking the IDE drive. I need to work out why
the PLL failed.

What does it report for FREQ and PLL if you boot 2.6.13.something on
it ?

