Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751963AbWHNJGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbWHNJGU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 05:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751962AbWHNJGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 05:06:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:30646 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751951AbWHNJGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 05:06:19 -0400
Subject: Re: module compiler version check still needed?
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <200608130648.36178.ak@suse.de>
References: <200608130648.36178.ak@suse.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 14 Aug 2006 11:06:17 +0200
Message-Id: <1155546377.2886.190.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-08-13 at 06:48 +0200, Andi Kleen wrote:
> Does anybody know of any reason why we would still need the compiler version
> check during module loading? AFAIK on i386 it was only needed to handle
> 2.95 (which got dropped) and on x86-64 it was never needed. Is there
> a need on any other architecture for it?

is there any harm in doing this check? Checking this for sure rules out
MANY nasty and really hard to debug corner cases... and there shouldn't
be any valid reason for doing this ever anyway...

