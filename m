Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbVBNKGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVBNKGB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 05:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVBNKGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 05:06:01 -0500
Received: from sd291.sivit.org ([194.146.225.122]:54163 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S261378AbVBNKF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 05:05:59 -0500
Date: Mon, 14 Feb 2005 11:07:39 +0100
From: Stelian Pop <stelian@popies.net>
To: Jean Delvare <khali@linux-fr.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, acpi-devel@lists.sourceforge.net,
       Pekka Enberg <penberg@gmail.com>
Subject: Re: [PATCH, new ACPI driver] new sony_acpi driver
Message-ID: <20050214100738.GC3233@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Jean Delvare <khali@linux-fr.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, acpi-devel@lists.sourceforge.net,
	Pekka Enberg <penberg@gmail.com>
References: <20050210161809.GK3493@crusoe.alcove-fr> <20050211113636.GI3263@crusoe.alcove-fr> <20050212142103.5e1a79f9.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050212142103.5e1a79f9.khali@linux-fr.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2005 at 02:21:03PM +0100, Jean Delvare wrote:

> > Based on feedback from Jean Delvare and Pekka Enberg, here is an
> > updated version.
> 
> Works for me (Vaio PCG-GR214EP). Tested with 2.6.11-rc3-bk8.
> 
> I then enabled the debug mode. I couldn't find anything relevant WRT
> what each additional file is supposed to do, but I still have noticed a
> number of things you might be interested in.
[...]

I have some interesting information from one user, who noticed that:

* pbr is the power-on brightness. It's the brightness that the
  laptop uses at power-on time.

* cdp is the CD-ROM power. Writing 0 to cdp turns off the cdrom in
  order to save a bit of power consumption.

I'll add this information in the docs.

Stelian.
-- 
Stelian Pop <stelian@popies.net>
