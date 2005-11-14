Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbVKNOSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbVKNOSH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 09:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbVKNOSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 09:18:07 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:35027 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751131AbVKNOSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 09:18:06 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alex Davis <alex14641@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051114133802.38755.qmail@web50205.mail.yahoo.com>
References: <20051114133802.38755.qmail@web50205.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 14 Nov 2005 14:49:39 +0000
Message-Id: <1131979779.5751.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-11-14 at 05:38 -0800, Alex Davis wrote:
> This will break ndiswrapper. Why can't we just leave this in and let people choose? 

If we spent our entire lives waiting for people to fix code nothing
would ever happen. Removing 8K stacks is a good thing to do for many
reasons. The ndis wrapper people have known it is coming for a long
time, and if it has a lot of users I'm sure someone in that community
will take the time to make patches.

