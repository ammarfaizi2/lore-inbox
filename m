Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbWAZUmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWAZUmN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 15:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWAZUmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 15:42:12 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:26250 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964868AbWAZUmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 15:42:11 -0500
Subject: Re: Asus P5A Reboots
From: Arjan van de Ven <arjan@infradead.org>
To: Simon Morgan <sjmorgan@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <de63970c0601261240i1770324ek@mail.gmail.com>
References: <de63970c0601261240i1770324ek@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 26 Jan 2006 21:42:08 +0100
Message-Id: <1138308128.2976.109.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-26 at 20:40 +0000, Simon Morgan wrote:
> 
> I'm having trouble running the installation for Arch 0.7.1 on an Asus
> P5A
> motherboard. The installation uses the 2.6.15 kernel and the problem
> is
> that during, or immediately after, the initrd decompression stage the
> machine reboots.

you most likely are getting an i686 kernel, while the cpu you have is an
AMD K6 which doesn't support the cmov instruction as used in i686
kernels...

