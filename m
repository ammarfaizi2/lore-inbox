Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264826AbUHJMnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264826AbUHJMnw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 08:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264929AbUHJMml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 08:42:41 -0400
Received: from the-village.bc.nu ([81.2.110.252]:55244 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264917AbUHJMka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 08:40:30 -0400
Subject: Re: BUG: bsd pts now climbs continuously
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <cf9hm5$tsu$1@terminus.zytor.com>
References: <Pine.LNX.4.30.0408091609100.31211-200000@link>
	 <1092086245.14770.2.camel@localhost.localdomain>
	 <cf9hm5$tsu$1@terminus.zytor.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092137890.16939.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 10 Aug 2004 12:38:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-08-10 at 05:07, H. Peter Anvin wrote:
> > ssh breaks at 9999 which is fun too. It runs out of buffer space
> > although because its been properly coded it doesn't overrun it just
> > starts corrupting utmp
> > 
> 
> This I believe is a glibc bug, and really needs to be fixed.
> Unfortunately glibc's handling of utmp is just incredibly broken.

How remarkable given the snprintf line in question is in the sshd
source code.

Alan

