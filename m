Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbWA3SxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWA3SxK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 13:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWA3SxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 13:53:10 -0500
Received: from main.gmane.org ([80.91.229.2]:64722 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964863AbWA3SxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 13:53:09 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
Subject: Re: 2.6.16-rc1-mm4
Date: Mon, 30 Jan 2006 19:50:47 +0100
Message-ID: <drln68$n82$1@sea.gmane.org>
References: <20060129144533.128af741.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: chaos.mk.cvut.cz
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
In-Reply-To: <20060129144533.128af741.akpm@osdl.org>
Cc: linux-kernel-announce@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm4/

In vgacon.c, there is a stray printk("vgacon delta: %i\n", lines); which
effectively disables the scrollback of the vga console (at least when
not using the new soft scrollback). Removing it fixes the problem.

-- 
Jindrich Makovicka

