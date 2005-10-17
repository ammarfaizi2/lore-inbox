Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbVJQGmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbVJQGmJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 02:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbVJQGmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 02:42:08 -0400
Received: from qproxy.gmail.com ([72.14.204.207]:25219 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932138AbVJQGmH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 02:42:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VLBYReu9CKeLdvps+O2DEd+r4LzjA/ajr3ppdDbRqhIQWAo1zKYlBawzis+lFHAkJI85u26yomn1jcAWKGJmEnFY0yN6ESsQzsWnig3VbPtjmwhPsOPDnOB/yFlmvqPAtX1ZCytbbL2uYFUoZb5uNCZAWTl/Q84p6gaXE7zXdvc=
Message-ID: <6bffcb0e0510162342h4abc9e56w@mail.gmail.com>
Date: Mon, 17 Oct 2005 06:42:06 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.14-rc4-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051016201920.53db2b89.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051016154108.25735ee3.akpm@osdl.org>
	 <6bffcb0e0510161713l7c3abbdq@mail.gmail.com>
	 <20051016201920.53db2b89.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/05, Andrew Morton <akpm@osdl.org> wrote:
> Beats me.  Please send .config.
>

Make modules_install works good on 2.6.14-rc4.

michal@debian:/usr/src/linux-mm$ bzip2 -cd
/home/michal/moje/pobrane/2.6.14-rc4-mm1.bz2 | patch -p1 --dry-run |
grep serial
[..]
patching file drivers/serial/8250_acpi.c
patching file drivers/serial/8250.c
patching file drivers/serial/8250_pnp.c

I'll try revert it later.

Regards,
Michal Piotrowski
