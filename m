Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbVFHMYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbVFHMYR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 08:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVFHMYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 08:24:17 -0400
Received: from fire.osdl.org ([65.172.181.4]:397 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262194AbVFHMYN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 08:24:13 -0400
Date: Wed, 8 Jun 2005 05:23:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Wiegley <jeffw@cyte.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: amd64 cdrom access locks system
Message-Id: <20050608052354.7b70052c.akpm@osdl.org>
In-Reply-To: <42A64556.4060405@cyte.com>
References: <42A64556.4060405@cyte.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Wiegley <jeffw@cyte.com> wrote:
>
> I've been having this problem in 2.6.12-rc2 and 2.6.12-rc6.
> 
>  Any continued access to /dev/hda causes a complete and total
>  lock up of the system. Nothing is logged to /var/log/kernel
>  or /var/log/messages. Just a solid freeze.
> 
>  This happens with at least cdparanoia and cdrecord as well.
> 
>  The machine is an AMD64 FX55 CPU running in a shuttle
>  ST20G5 chassis.

Can you identify an earlier kernel which worked OK?

How locked up is it?  Does sysrq-P not work?  Is it pingable?  Tried
enabling the nmi watchdog?

