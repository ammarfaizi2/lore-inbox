Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265029AbUIIOlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbUIIOlg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 10:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264997AbUIIOlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 10:41:36 -0400
Received: from the-village.bc.nu ([81.2.110.252]:4523 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265044AbUIIOjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 10:39:53 -0400
Subject: Re: 2.6.9-rc1-mm4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Blazejowski <diffie@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <9dda3492040908214277f3d454@mail.gmail.com>
References: <9dda3492040908214277f3d454@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094737054.14646.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 09 Sep 2004 14:37:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-09 at 05:42, Paul Blazejowski wrote:
> IT8212 driver fails to recognize RAID0 setup. The driver is built in
> as module (it8212).

You need the -ac patch for this. I depend upon some core IDE fixes that
I'm waiting for Bartlomiej to merge in order to do the RAID devices.

Alan

