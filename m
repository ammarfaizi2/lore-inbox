Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbUKPHFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbUKPHFm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 02:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbUKPHFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 02:05:42 -0500
Received: from linaeum.absolutedigital.net ([63.87.232.45]:40639 "EHLO
	linaeum.absolutedigital.net") by vger.kernel.org with ESMTP
	id S261925AbUKPHFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 02:05:38 -0500
Date: Tue, 16 Nov 2004 02:05:38 -0500 (EST)
From: Cal Peake <cp@absolutedigital.net>
To: Alex Davis <alex14641@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: compile errors with 2.6.10rc2
In-Reply-To: <20041116050229.43528.qmail@web50204.mail.yahoo.com>
Message-ID: <Pine.LNX.4.61.0411160200190.27118@linaeum.absolutedigital.net>
References: <20041116050229.43528.qmail@web50204.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2004, Alex Davis wrote:

> I get the following errors during compilation:
> 
> net/core/dev.c:1054: error: conflicting types for 'skb_checksum_help'
> include/linux/netdevice.h:950: error: previous declaration of 'skb_checksum_help' was here
> net/core/dev.c:1054: error: conflicting types for 'skb_checksum_help'
> include/linux/netdevice.h:950: error: previous declaration of 'skb_checksum_help' was here
> net/core/dev.c:1468: error: redefinition of 'netif_rx_ni'
> include/linux/netdevice.h:698: error: previous definition of 'netif_rx_ni' was here
> net/core/dev.c:2648: warning: static declaration of 'dev_new_index' follows non-static declaration
> include/linux/netdevice.h:556: warning: previous declaration of 'dev_new_index' was here
> make[2]: *** [net/core/dev.o] Error 1
> make[1]: *** [net/core] Error 2
> make: *** [net] Error 2

It looks like your source tree is clobbered. Try rebuilding with a 
pristine one and see if that helps.

-- Cal

