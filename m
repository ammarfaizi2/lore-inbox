Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266810AbUHISBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266810AbUHISBK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 14:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266813AbUHISBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 14:01:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20439 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266810AbUHISBH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 14:01:07 -0400
Date: Mon, 9 Aug 2004 10:59:52 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Stephane Jourdois <stephane@rubis.org>,
       Filip Van Raemdonck <filipvr@xs4all.be>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <greg@kroah.com>,
       zaitcev@redhat.com
Subject: Re: 2.6.8-rc2-mm1: bluetooth broken?
Message-Id: <20040809105952.45725e0c@lembas.zaitcev.lan>
References: <20040808191912.GA620@elf.ucw.cz>
	<1092003277.2773.45.camel@pegasus>
	<20040809095425.GA12667@debian>
	<1092046959.21815.15.camel@pegasus>
	<20040809120705.GA23073@diamant.rubis.org>
	<1092057843.21815.21.camel@pegasus>
	<20040809133452.GA24530@diamant.rubis.org>
	<1092061267.4639.4.camel@pegasus>
	<20040809151229.GA8651@diamant.rubis.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Aug 2004 18:49:05 +0200
Marcel Holtmann <marcel@holtmann.org> wrote:

> --- ub.c.orig   2004-08-09 18:40:38.000000000 +0200
> +++ ub.c        2004-08-09 18:24:15.000000000 +0200
> @@ -318,6 +318,7 @@
>  static struct usb_device_id ub_usb_ids[] = {
>         // { USB_DEVICE_VER(0x0781, 0x0002, 0x0009, 0x0009) },  /* SDDR-31 */
>         { USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_SCSI, US_PR_BULK) },
> +       { }
>  };

Tsk, tsk, what a dumb bug. Thanks, Marcel.

-- Pete
