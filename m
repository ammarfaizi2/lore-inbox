Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161002AbWAXRNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161002AbWAXRNg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 12:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161003AbWAXRNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 12:13:36 -0500
Received: from [81.2.110.250] ([81.2.110.250]:37824 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1161004AbWAXRNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 12:13:34 -0500
Subject: Re: 2.6.16-rc1-mm2 pata driver confusion
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Ed Sweetman <safemode@comcast.net>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <Pine.LNX.4.58.0601240904110.26036@shark.he.net>
References: <43D5CC88.9080207@comcast.net>
	 <1138116579.14675.22.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0601240904110.26036@shark.he.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 24 Jan 2006 17:13:48 +0000
Message-Id: <1138122829.14675.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-01-24 at 09:05 -0800, Randy.Dunlap wrote:
> What is "MPIIX" anyway?

MPIIX was an early intel mobile chip. Its a PCI bridge, glue and the
like for pentium laptops with a built in PIO ATA controller.

> and while I'm looking at the config menu, why do both
> Compaq Triflex and Intel PATA MPIIX say (Raving Lunatic)?

So people don't casually select them. The current MPIIX driver will
remove the raving lunatic once it gets upstream.


