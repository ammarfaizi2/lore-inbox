Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271207AbTGWSPy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 14:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271206AbTGWSPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 14:15:54 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:4347 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271197AbTGWSPv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 14:15:51 -0400
Subject: Re: [PATCH 2.5] fixes for airo.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Javier Achirica <achirica@telefonica.net>
Cc: Daniel Ritz <daniel.ritz@gmx.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net <linux-net@vger.kernel.org>
In-Reply-To: <Pine.SOL.4.30.0307232006310.15976-100000@tudela.mad.ttd.net>
References: <Pine.SOL.4.30.0307232006310.15976-100000@tudela.mad.ttd.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058984406.5515.108.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Jul 2003 19:20:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-23 at 19:10, Javier Achirica wrote:
> Ok, sure. But then, if you are in interrupt context, whet do you do with
> the packet?

What packet. You marked the interface busy for transmit, so where is it
going to come from, or you can buffer a single packet I guess

