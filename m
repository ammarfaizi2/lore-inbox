Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422833AbWJPTFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422833AbWJPTFd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 15:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422834AbWJPTFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 15:05:33 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:28633 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1422833AbWJPTFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 15:05:33 -0400
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [Patch 3/3] Driver core: Per-subsystem multithreaded probing.
Date: Mon, 16 Oct 2006 21:05:27 +0200
User-Agent: KMail/1.9.5
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Greg K-H <greg@kroah.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0610161040570.7103-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0610161040570.7103-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610162105.28035.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That's not quite true.  You could acquire dev->parent->sem always, just to
> be certain.  However USB shouldn't use this form of multithreaded probing
> in any case; it should instead use multiple threads for khubd.

Is anyone working on this (multiple threads for khubd)?

Ciao,

Duncan.
