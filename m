Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262040AbVCOWl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbVCOWl2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 17:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVCOWk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 17:40:27 -0500
Received: from fire.osdl.org ([65.172.181.4]:17825 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262040AbVCOWhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 17:37:13 -0500
Date: Tue, 15 Mar 2005 14:37:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CON_BOOT
Message-Id: <20050315143711.4ae21d88.akpm@osdl.org>
In-Reply-To: <20050315222706.GI21986@parcelfarce.linux.theplanet.co.uk>
References: <20050315222706.GI21986@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <matthew@wil.cx> wrote:
>
> +	if (console_drivers && (console_drivers->flags & CON_BOOT)) {
> +		unregister_console(console_drivers);
> +		console->flags &= ~CON_PRINTBUFFER;
> +	}
> +

Should we support more than a single CON_BOOT-labelled driver?
