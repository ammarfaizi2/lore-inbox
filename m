Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbVCIQ5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVCIQ5R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 11:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbVCIQ5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 11:57:17 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:28554 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261790AbVCIQ5Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 11:57:16 -0500
Subject: Re: [PATCH] remove dead cyrix/centaur mtrr init code
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: torvalds@osdl.org
In-Reply-To: <200503081937.j28Jb4Vd020597@hera.kernel.org>
References: <200503081937.j28Jb4Vd020597@hera.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110387326.28860.199.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 09 Mar 2005 16:55:27 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-03-08 at 17:40, Linux Kernel Mailing List wrote:
> ChangeSet 1.2094, 2005/03/08 09:40:59-08:00, Andries.Brouwer@cwi.nl
> 
> 	[PATCH] remove dead cyrix/centaur mtrr init code


This patch was discussed previously and declared incorrect. The ->init
method call is missing in the base mtrr code.

Should be reverted and/or fixed properly.


