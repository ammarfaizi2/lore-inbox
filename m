Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262885AbVCDLPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262885AbVCDLPm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 06:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262876AbVCDLNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 06:13:45 -0500
Received: from fire.osdl.org ([65.172.181.4]:37848 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262798AbVCDLEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 06:04:43 -0500
Date: Fri, 4 Mar 2005 03:04:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, mjg59@scrf.ucam.org, hare@suse.de
Subject: Re: swsusp: allow resume from initramfs
Message-Id: <20050304030410.3bc5d4dc.akpm@osdl.org>
In-Reply-To: <20050304101631.GA1824@elf.ucw.cz>
References: <20050304101631.GA1824@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:
>
> When using a fully modularized kernel it is necessary to activate
>  resume manually as the device node might not be available during
>  kernel init.

I don't understand how this can be affected by the modularness of the
kernel.  Can you explain a little more?

Would it not be simpler to just add "resume=03:02" to the boot command line?
