Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWDURpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWDURpw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 13:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWDURpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 13:45:52 -0400
Received: from mail.axxeo.de ([82.100.226.146]:53160 "EHLO mail.axxeo.de")
	by vger.kernel.org with ESMTP id S932239AbWDURpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 13:45:51 -0400
From: Ingo Oeser <netdev@axxeo.de>
Organization: Axxeo GmbH
To: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Fw: [Bug 6421] New: kernel 2.6.10-2.6.16 on alpha: arch/alpha/kernel/io.c, iowrite16_rep() BUG_ON((unsigned long)src & 0x1) triggered
Date: Fri, 21 Apr 2006 19:45:36 +0200
User-Agent: KMail/1.7.2
Cc: Paul Gortmaker <p_gortmaker@yahoo.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, tomri@gmx.net,
       Ingo Oeser <ioe-lkml@rameria.de>
References: <20060421102757.45d26db0@localhost.localdomain>
In-Reply-To: <20060421102757.45d26db0@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604211945.37129.netdev@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> Looks like PIO at unaligned addresses doesn't work on alpha...

Maybe this should be fixed similiar to ioread32_rep in  arch/alpha/kernel/io.c?

This may slow it down, but will not break it.

> Begin forwarded message:
> 
> Date: Fri, 21 Apr 2006 02:35:45 -0700
> From: bugme-daemon@bugzilla.kernel.org
> To: shemminger@osdl.org
> Subject: [Bug 6421] New: kernel 2.6.10-2.6.16 on alpha: arch/alpha/kernel/io.c, iowrite16_rep() BUG_ON((unsigned long)src & 0x1) triggered

Regards

Ingo Oeser
