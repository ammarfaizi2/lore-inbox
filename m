Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262769AbVCDNHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262769AbVCDNHQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 08:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262908AbVCDNFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 08:05:22 -0500
Received: from [81.2.110.250] ([81.2.110.250]:48091 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S263092AbVCDM67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 07:58:59 -0500
Subject: Re: [2.6 patch] unexport complete_all
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Mike Waychison <mike@waychison.com>, Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <58cb370e0503040240314120ea@mail.gmail.com>
References: <422817C3.2010307@waychison.com>
	 <58cb370e0503040240314120ea@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1109940906.26799.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 04 Mar 2005 12:55:09 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andrew, what is the policy for adding exports for out of tree GPL code?
> 
> IMHO although it is convenient for maintainers of such code it is
> inconvenient for us (ie. when making changes to code) and gives
> people false assumptions about stability of *in-kernel* APIs.

Why isn't it _GPL if it is for a specific module need ?

Even more so for those cases where a person adds a non _GPL export for
another persons code. 
