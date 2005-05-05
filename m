Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261961AbVEEWSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbVEEWSN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 18:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbVEEWSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 18:18:13 -0400
Received: from [81.2.110.250] ([81.2.110.250]:3736 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261961AbVEEWSK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 18:18:10 -0400
Subject: Re: /proc/ide/hd?/settings obsolete in 2.6.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Wakko Warner <wakko@animx.eu.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050505205351.GC17861@animx.eu.org>
References: <20050505004854.GA16550@animx.eu.org>
	 <58cb370e050505031041c2c164@mail.gmail.com>
	 <20050505111324.GA17223@animx.eu.org>
	 <58cb370e050505051360d0588c@mail.gmail.com>
	 <1115304977.23360.83.camel@localhost.localdomain>
	 <20050505153807.GB17724@animx.eu.org>
	 <1115310081.19842.89.camel@localhost.localdomain>
	 <20050505163316.GB17861@animx.eu.org>
	 <1115315925.19842.92.camel@localhost.localdomain>
	 <20050505205351.GC17861@animx.eu.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1115331396.23360.107.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 05 May 2005 23:16:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-05-05 at 21:53, Wakko Warner wrote:
> What is the right way for apps that need it to get it?  Or is the kernel
> just going to obsolete geometry entirely?

The truth is the kernel never knew. It often got it right on x86 but it
was never reliable. There are too many platform specific heuristics and
complications that depend on the intended use of the geometry for the
kernel to be the right place to do this.

The fact it got pushed out was intentional and something I agree with..


