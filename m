Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWBUMo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWBUMo2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 07:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWBUMo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 07:44:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18897 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932230AbWBUMo1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 07:44:27 -0500
Date: Tue, 21 Feb 2006 04:42:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: greg@kroah.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-pm@osdl.org
Subject: Re: [PATCH 3/4] [pm] Minor updates to core suspend/resume functions
Message-Id: <20060221044244.686df618.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.50.0602201653580.21145-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0602201653580.21145-100000@monsoon.he.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel <mochel@digitalimplant.org> wrote:
>
> - Check the real state the device and parent are in compared
>    to the the real state requested, instead of just checking
>    that the event types are the same.
> 
>  - Update debug and error messages to display the real states.

This patch causes resume failures here.  suspend-to-ram, resume and the
long-suffering USB wireless mouse is dead - the power light on the USB
gadget is off and nothing I can do will persuade it to come back on.

