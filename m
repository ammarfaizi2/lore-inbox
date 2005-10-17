Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbVJQANh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbVJQANh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 20:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbVJQANh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 20:13:37 -0400
Received: from qproxy.gmail.com ([72.14.204.194]:13836 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932086AbVJQANh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 20:13:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y2ut8hOZTpl7NloBXhWyDge9oB3UWvvYzM8g3NoU8ens2dygsBAWUfkQTn6/gez7oazXFvU4dXM3CD49IJRydanYEbmm9GHxDCjj6BeVkcYnoV6r/dRwzHxGgPt0INMHPoMK3svIPb/ejx19hyRbH35ISyask6TSRiU0cT8RfoI=
Message-ID: <6bffcb0e0510161713l7c3abbdq@mail.gmail.com>
Date: Mon, 17 Oct 2005 00:13:36 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.14-rc4-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051016154108.25735ee3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051016154108.25735ee3.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16/10/05, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc4/2.6.14-rc4-mm1/
>
[snip]

I have noticed some warnings while "make modules_install"

if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F
System.map  2.6.14-rc4-mm1; fi
WARNING: Module
/lib/modules/2.6.14-rc4-mm1/kernel/drivers/serial/serial_core.ko
ignored, due to loop
WARNING: Module
/lib/modules/2.6.14-rc4-mm1/kernel/drivers/serial/8250_pnp.ko ignored,
due to loop
WARNING: Module
/lib/modules/2.6.14-rc4-mm1/kernel/drivers/serial/8250_pci.ko ignored,
due to loop
WARNING: Module
/lib/modules/2.6.14-rc4-mm1/kernel/drivers/serial/8250_acpi.ko
ignored, due to loop
WARNING: Loop detected:
/lib/modules/2.6.14-rc4-mm1/kernel/drivers/serial/8250.ko needs
serial_core.ko which needs 8250.ko again!
WARNING: Module
/lib/modules/2.6.14-rc4-mm1/kernel/drivers/serial/8250.ko ignored, due
to loop

Regards,
Michal Piotrowski
