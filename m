Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbVI3EtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbVI3EtZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 00:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbVI3EtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 00:49:25 -0400
Received: from falcon30.maxeymade.com ([24.173.215.190]:34538 "EHLO
	falcon30.maxeymade.com") by vger.kernel.org with ESMTP
	id S932268AbVI3EtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 00:49:24 -0400
Message-Id: <200509300449.j8U4n94d014765@falcon30.maxeymade.com>
X-Mailer: exmh version 2.7.2.1 01/17/2005 with nmh-1.1
In-reply-to: <20050930010228.GG6173@austin.ibm.com> 
To: linas <linas@austin.ibm.com>
cc: paulus@samba.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] ppc64: EEH Halt if bad drivers spin in error condition 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 29 Sep 2005 23:49:09 -0500
From: Doug Maxey <dwm@maxeymade.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 29 Sep 2005 20:02:28 CDT, linas wrote:
>
>07-eeh-spin-counter.patch
>
>One an EEH event is triggers, all further I/O to a device is blocked (until
>reset).  Bad device drivers may end up spinning in their interrupt handlers, 
>trying to read an interrupt status register that will never change state.
>This patch moves that spin counter to a per-device structure, and adds
>some diagnostic prints to help locate the bad driver.
>

Which struct gets the element?

++doug

