Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbVECWVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbVECWVa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 18:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261859AbVECWVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 18:21:30 -0400
Received: from animx.eu.org ([216.98.75.249]:38280 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261858AbVECWVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 18:21:23 -0400
Date: Tue, 3 May 2005 18:20:55 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Rick Warner <rick@microway.com>, linux-kernel@vger.kernel.org
Subject: Re: zImage on 2.6?
Message-ID: <20050503222055.GD12199@animx.eu.org>
Mail-Followup-To: Brian Gerst <bgerst@didntduck.org>,
	Rick Warner <rick@microway.com>, linux-kernel@vger.kernel.org
References: <20050503012951.GA10459@animx.eu.org> <200505031206.09245.rick@microway.com> <20050503164012.GE11937@animx.eu.org> <4277C6A4.3070409@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4277C6A4.3070409@didntduck.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:
> Wakko Warner wrote:
> >Please keep me CCd
> >As far as my question, it still stands.  Is bzImage required (i386/x86) for
> >a 2.6 kernel?
> >
> 
> More or less yes.  As you're finding out, it's very difficult to build a 
> functioning 2.6 kernel that fits the size requirements of the zImage 
> format.  Really, the zImage format is not needed anymore.  It was only 
> kept around because a small number of ancient BIOSes failed to load the 
> bzImage format with the now defunct floppy boot block.  There is no size 
> difference in the resulting zImage or bzImage, only the load address is 
> different.

Ok, thanks.  Definately wanted to know this.  The kernel will always be
loaded by some boot loader (be it grub or syslinux)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
