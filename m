Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbUJ3QSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbUJ3QSf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 12:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbUJ3QRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 12:17:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55686 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261190AbUJ3QPp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 12:15:45 -0400
Date: Sat, 30 Oct 2004 09:15:22 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Paulo da Silva <psdasilva@esoterica.pt>, linux-kernel@vger.kernel.org
Subject: Re: k 2.6.9: ub module causes /dev/sda and /dev/sda1 not being
 created
Message-ID: <20041030091522.6f2da605@lembas.zaitcev.lan>
In-Reply-To: <mailman.1099103401.11097.linux-kernel2news@redhat.com>
References: <mailman.1099103401.11097.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.13; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Oct 2004 03:19:41 +0100, Paulo da Silva <psdasilva@esoterica.pt> wrote:

> I had problems with my pen drive.
> Module ub (autolodaded) recognized the pendrive. So /dev/sda
> and /dev/sda1 didn't get created. After removing ub module
> from kernel config I could mount the pen drive as /dev/sda1.

This is intentional. The ub takes over certain functions of usb-storage
when it is configured in. Is it a problem? If yes, why?

-- Pete
