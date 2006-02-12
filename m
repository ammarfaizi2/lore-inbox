Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWBLKp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWBLKp7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 05:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWBLKp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 05:45:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45468 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750785AbWBLKp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 05:45:58 -0500
Date: Sun, 12 Feb 2006 02:45:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: xose.vazquez@gmail.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: old patches in -mm
Message-Id: <20060212024508.117d4603.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0602121134170.25363@yvahk01.tjqt.qr>
References: <43EE415F.2000805@gmail.com>
	<Pine.LNX.4.61.0602121134170.25363@yvahk01.tjqt.qr>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
>
> > hi,
> >
> > There are 35 patches(not included reiser4 and post-halloween-doc) older
> > than 2 months that still are not in mainline. Forgotten or experimental ?
> >
> >
> > 2.6-sony_acpi4.patch
> >
> Forgotten, I think. This one showed no problems for me until now.
> 

The ACPI guys don't like machine-specific drivers like this, apparently -
features are supposed to be controlled via the machine's BIOS ACPI methods.

But given the state of Sony ACPI documentaion (ie: none) that might not
work out.  I'll ask about it.
