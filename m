Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261952AbVCAP7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbVCAP7L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 10:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVCAP7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 10:59:10 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:43457 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261952AbVCAP7H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 10:59:07 -0500
Subject: Re: Breakage from patch: Only root should be able to set the
	N_MOUSE line discipline.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, akpm@osdl.org, vojtech@suse.de
In-Reply-To: <20050301114718.GA5375@ucw.cz>
References: <200502030209.j1329xTG013818@hera.kernel.org>
	 <1109416402.2584.5.camel@localhost.localdomain>
	 <20050301114718.GA5375@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1109692629.15797.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 01 Mar 2005 15:57:13 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-03-01 at 11:47, Vojtech Pavlik wrote:
> A nonprivileged user could inject mouse movement and/or keystrokes
> (using the sunkbd driver) into the input subsystem, taking over the
> console/X, where another user is logged in.

Ouch. Ok that explains much.

