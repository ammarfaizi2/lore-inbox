Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030244AbWFOLct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbWFOLct (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 07:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbWFOLct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 07:32:49 -0400
Received: from mail.polimi.it ([131.175.12.3]:41903 "EHLO polimi.it")
	by vger.kernel.org with ESMTP id S1030240AbWFOLcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 07:32:48 -0400
Date: Thu, 15 Jun 2006 13:32:20 +0200
From: Stefano Brivio <stefano.brivio@polimi.it>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
       mb@bu3sch.de, akpm <akpm@osdl.org>
Subject: Re: [Ubuntu PATCH] Broadcom wireless patch, PCIE/Mactel support
Message-ID: <20060615133220.57d8dd26@localhost>
In-Reply-To: <44909A3F.4090905@oracle.com>
References: <44909A3F.4090905@oracle.com>
X-Mailer: Sylpheed-Claws 2.2.0 (GTK+ 2.8.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-PMX-Version: 5.2.0.264296, Antispam-Engine: 2.4.0.264935, Antispam-Data: 2006.6.15.41933
X-PerlMx-Spam: Gauge=I, Probability=81%, Report='RELAY_IN_CBL 8, __CP_URI_IN_BODY 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-Spam-Score: ***** (Spam Prob: 81% GAuge: XXXXXXXX)
X-Probable-Spam: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2006 16:22:39 -0700
Randy Dunlap <randy.dunlap@oracle.com> wrote:

> From: Matthew Garrett <mjg59@srcf.ucam.org>
> 
> Broadcom wireless patch, PCIE/Mactel support
> 
> http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=1373a8487e911b5ee204f4422ddea00929c8a4cc
> 
> This patch adds support for PCIE cores to the bcm43xx driver. This is
> needed for wireless to work on the Intel imacs. I've submitted it to
> bcm43xx upstream.

NACK.
This has been superseded by my patchset:
http://www.mail-archive.com/bcm43xx-dev@lists.berlios.de/msg01267.html

I'm still waiting for more testing so I didn't request merging to mainline
yet. Plus, this patch is copied from this one:
http://www.mail-archive.com/bcm43xx-dev@lists.berlios.de/msg00919.html
which is wrong. Please see my patchset and new specs for reference.

PS: Next time, don't be rude and send patches to the maintainers.


-- 
Ciao
Stefano
