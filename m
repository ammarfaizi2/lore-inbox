Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266249AbUIALxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266249AbUIALxW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 07:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266214AbUIALqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 07:46:50 -0400
Received: from the-village.bc.nu ([81.2.110.252]:60810 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266204AbUIALqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 07:46:36 -0400
Subject: Re: Linux 2.6.8.1-ac1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Ionescu <i_p_a_u_l@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <pan.2004.09.01.08.17.41.824046@yahoo.com>
References: <20040831170839.GA18799@devserv.devel.redhat.com>
	 <pan.2004.09.01.08.17.41.824046@yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094035469.2374.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 01 Sep 2004 11:44:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-01 at 09:17, Paul Ionescu wrote:
> Hi Alan,
> 
> I will try this patch on an IBM T41 Thinkpad, and I am interested in its
> IDE Hotplug functionality.
> Will I be able to swap IDE devices in my ultrabay without using "idectl 1
> rescan" (using this patch only) ?
> Do I need any other special tool for ide hotswapping in this case?
> Or should I wait for IDE hotplug at the device level ?

You need device level hotplug for the ultrabay drive rather than
controller level. Thats next on the hit list after various other non IDE
jobs.

