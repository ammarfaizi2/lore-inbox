Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbVLNF5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbVLNF5g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 00:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbVLNF5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 00:57:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13258 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751301AbVLNF5f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 00:57:35 -0500
Date: Tue, 13 Dec 2005 21:57:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org, stelian@popies.net,
       malattia@linux.it, len.brown@intel.com
Subject: Re: [PATCH] Sonypi: convert to the new platform device interface
Message-Id: <20051213215711.73a79800.akpm@osdl.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F840A6A9A2D@pdsmsx403>
References: <3ACA40606221794F80A5670F0AF15F840A6A9A2D@pdsmsx403>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Yu, Luming" <luming.yu@intel.com> wrote:
>
> But, from my understanding, sonypi.c should be cleanly implemented in ACPI.
>

heh, good luck.  I've spent a decent chunk of this week making Linux suck
less than 100% on a new Vaio, Am currently at 95%.  Poking things into
sonypi's /proc/acpi/brightness is the only way known of controlling the
screen brightness.  One of the mysterious and undocumented ACPI calls will
do it, but we don't know which, nor how.
