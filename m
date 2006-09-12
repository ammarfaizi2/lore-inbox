Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965228AbWILQhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965228AbWILQhq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 12:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965230AbWILQhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 12:37:45 -0400
Received: from mail.suse.de ([195.135.220.2]:6838 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965228AbWILQhp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 12:37:45 -0400
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] quirks: Flag up and handle the AMD 8151 Errata #24
Date: Tue, 12 Sep 2006 17:10:57 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <1158078540.6780.61.camel@localhost.localdomain>
In-Reply-To: <1158078540.6780.61.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609121710.57393.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 September 2006 18:29, Alan Cox wrote:
> AMD states the following
>
> "Some PCI cards generate peer-to-peer posted-write traffic targetting
> the AGP bridge (from the PCI bus, through the graphics tunnel to the AGP
> bus). The combination of such cards and some AGP cards can generate
> traffic patters that result in a system deadlock."

Hmm, you add all that code just to trigger printks? Looks like overkill
to me. 

-Andi


