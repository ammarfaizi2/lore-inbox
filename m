Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161159AbWJYU1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161159AbWJYU1m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 16:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161185AbWJYU1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 16:27:42 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:32225 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161159AbWJYU1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 16:27:41 -0400
Subject: Re: incorrect taint of ndiswrapper
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Roskin <proski@gnu.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1161807069.3441.33.camel@dv>
References: <1161807069.3441.33.camel@dv>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 25 Oct 2006 21:30:26 +0100
Message-Id: <1161808227.7615.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-10-25 am 16:11 -0400, ysgrifennodd Pavel Roskin:
> I don't see any legal reasons behind this restriction.  A driver under
> GPL should be able to use any exported symbols.  EXPORT_SYMBOL_GPL is a
> technical mechanism of enforcing GPL against non-free code, but
> ndiswrapper is free.  The non-free NDIS drivers are not using those
> symbols.

The combination of GPL wrapper and the NDIS driver as a work is not free
(in fact its questionable if its even legal to ship such a combination
together).


