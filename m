Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264383AbUAVGQo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 01:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264410AbUAVGQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 01:16:44 -0500
Received: from pizda.ninka.net ([216.101.162.242]:23206 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264383AbUAVGQn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 01:16:43 -0500
Date: Wed, 21 Jan 2004 22:08:23 -0800
From: "David S. Miller" <davem@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sungem: add support for G5 PowerMac, some PM fixes
Message-Id: <20040121220823.63d46968.davem@redhat.com>
In-Reply-To: <1074750642.974.109.camel@gaston>
References: <1074750642.974.109.camel@gaston>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jan 2004 16:50:43 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> +			if (gp->pdev->device == PCI_DEVICE_ID_APPLE_K2_GMAC)
> +				break;
> +
> +       			for (i = 0; i < 32; i++) {

Please fix this indentation, and I'll happily apply this ;-)

I assume you'll have a 2.4.x variant of this patch too?
