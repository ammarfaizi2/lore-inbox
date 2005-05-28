Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbVE1OBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbVE1OBG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 10:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbVE1OBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 10:01:06 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:21184 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261461AbVE1OBE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 10:01:04 -0400
Subject: Re: spinaphore conceptual draft (was discussion of RT patch)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Nicol <davidnicol@gmail.com>
Cc: john cooper <john.cooper@timesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <934f64a205052715315c21d722@mail.gmail.com>
References: <934f64a205052715315c21d722@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1117288744.2685.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 28 May 2005 14:59:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like a description of buzz locks used by various user space
libraries - spin briefly then assume the other cause of contention is
slow (or in user space that we pre-empted it) and be polite.

Alan

