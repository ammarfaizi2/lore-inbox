Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269967AbTGXS5c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 14:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269968AbTGXS5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 14:57:32 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:42746 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S269967AbTGXS5b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 14:57:31 -0400
Subject: Re: time for some drivers to be removed?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bas Mevissen <ml@basmevissen.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F1FFC94.7080409@basmevissen.nl>
References: <Pine.LNX.4.53.0307240817520.19533@localhost.localdomain>
	 <1059058737.7994.25.camel@dhcp22.swansea.linux.org.uk>
	 <3F1FFC94.7080409@basmevissen.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059073642.7993.31.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Jul 2003 20:07:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-07-24 at 16:34, Bas Mevissen wrote:
> Is this something for the kernel config? Just below CONFIG_EXPERIMENTEL 
> in the menu, add CONFIG_OBSOLETE. The 'make allyesconfig' and the like 
> can ignore experimental and obsolete stuff.

The OBSOLETE stuff is already used on a couple of drivers that are obsolete
since 2.2 (although I fixed two of them as they got fixed in 2.4 in the
end)


