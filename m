Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWDPRtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWDPRtM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 13:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWDPRtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 13:49:11 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42403 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750766AbWDPRtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 13:49:10 -0400
Subject: Re: Which device did I boot from?
From: Arjan van de Ven <arjan@infradead.org>
To: MrUmunhum@popdial.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44401071.5080700@popdial.com>
References: <44401071.5080700@popdial.com>
Content-Type: text/plain
Date: Sun, 16 Apr 2006 19:49:07 +0200
Message-Id: <1145209747.3809.16.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-14 at 14:13 -0700, William Estrada wrote:
> Hi group,
> 
>   Is there a way to determine which device I have booted from?  

that may be really hard; EDD can tell you what disk your bios will try,
but remember that you may have booted from USB (not covered by EDD) or
even ethernet (using PXE). The kernel doesn't know... since all it knows
is that the bootloader put it into memory somewhere

