Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268896AbUIXQpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268896AbUIXQpA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 12:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268947AbUIXQmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 12:42:47 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:53735 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268966AbUIXQjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 12:39:21 -0400
Subject: Re: i386 entry.S problems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: arjanv@redhat.com
Cc: Jan Beulich <JBeulich@novell.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1096037828.2612.53.camel@laptop.fenrus.com>
References: <s1543914.047@emea1-mh.id2.novell.com>
	 <1096037828.2612.53.camel@laptop.fenrus.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096040201.10143.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 24 Sep 2004 16:36:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-24 at 15:57, Arjan van de Ven wrote:
> I wonder why we still have the lcall7/lcall27 entry points in the
> kernel; nothing can legitemately use them

Linuxabi and the xabi stuff used to use them, but I guess those entry
points belong in the xabi patch not in the kernel really.

