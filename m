Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269576AbUICKNC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269576AbUICKNC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 06:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269464AbUICKCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 06:02:04 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:34309 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269599AbUICJ5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 05:57:32 -0400
Date: Fri, 3 Sep 2004 10:57:21 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>, bjorn.helgaas@hp.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm3
Message-ID: <20040903105721.A3211@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, bjorn.helgaas@hp.com,
	linux-kernel@vger.kernel.org
References: <20040903014811.6247d47d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040903014811.6247d47d.akpm@osdl.org>; from akpm@osdl.org on Fri, Sep 03, 2004 at 01:48:11AM -0700
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +acpi-based-i8042-keyboard-aux-controller-enumeration.patch
> 
>  Enumerate 8042 controllers with ACPI

Umm, we kept i8042.c clean from arch depencies so far..  Please move this
intto and 8042-acpiio.h header or something.

