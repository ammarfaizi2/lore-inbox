Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267312AbUHIWXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267312AbUHIWXO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 18:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267318AbUHIWXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 18:23:14 -0400
Received: from the-village.bc.nu ([81.2.110.252]:41675 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267312AbUHIWTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 18:19:51 -0400
Subject: Re: BUG: bsd pts now climbs continuously
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jdh <root@hend.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0408091609100.31211-200000@link>
References: <Pine.LNX.4.30.0408091609100.31211-200000@link>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092086245.14770.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 09 Aug 2004 22:17:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-09 at 21:30, jdh wrote:
> While I'm sure the security issues are valid?  I do question completely
> changing the functionality.  I doubt changing the pts/n numbers
> helps those looking for backward compatibility at all.

ssh breaks at 9999 which is fun too. It runs out of buffer space
although because its been properly coded it doesn't overrun it just
starts corrupting utmp

