Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263172AbTKETsr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 14:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263170AbTKETsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 14:48:47 -0500
Received: from pizda.ninka.net ([216.101.162.242]:16538 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263172AbTKETsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 14:48:38 -0500
Date: Wed, 5 Nov 2003 11:41:31 -0800
From: "David S. Miller" <davem@redhat.com>
To: jt@hpl.hp.com
Cc: jt@bougret.hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6 IrDA] IrNET status event Oops
Message-Id: <20031105114131.4433ec2f.davem@redhat.com>
In-Reply-To: <20031105194042.GC24323@bougret.hpl.hp.com>
References: <20031105194042.GC24323@bougret.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Nov 2003 11:40:42 -0800
Jean Tourrilhes <jt@bougret.hpl.hp.com> wrote:

> ir2609_irnet_ppp_open_race-2.diff :
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 	o [CRITICA] Prevent sending status event to dead/kfree sockets
> 	o [CORRECT] Disable PPP access before deregistration
> 		PPP deregistration might sleep -> race condition

Applied, thanks.
