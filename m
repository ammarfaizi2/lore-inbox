Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbWIIPxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWIIPxh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 11:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbWIIPxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 11:53:37 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60906 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964787AbWIIPxe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 11:53:34 -0400
Subject: Re: [PATCH] watchdog: use ENOTTY instead of ENOIOCTLCMD in ioctl()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Samuel Tardieu <sam@rfc1149.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2006-09-09-17-34-32+trackit+sam@rfc1149.net>
References: <2006-09-09-17-34-32+trackit+sam@rfc1149.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 09 Sep 2006 17:16:43 +0100
Message-Id: <1157818604.6877.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-09-09 am 17:34 +0200, ysgrifennodd Samuel Tardieu:
> Return ENOTTY instead of ENOIOCTLCMD in user-visible ioctl() results
> 
> The watchdog drivers used to return ENOIOCTLCMD for bad ioctl() commands.
> ENOIOCTLCMD should not be visible by the user, so use ENOTTY instead.
> 
> Signed-off-by: Samuel Tardieu <sam@rfc1149.net>


Acked-by: Alan Cox <alan@redhat.com>

