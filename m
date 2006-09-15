Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWIOWOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWIOWOL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 18:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWIOWOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 18:14:11 -0400
Received: from mail.kroah.org ([69.55.234.183]:5835 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932313AbWIOWOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 18:14:10 -0400
Date: Fri, 15 Sep 2006 14:50:42 -0700
From: Greg KH <gregkh@suse.de>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.18-rc6-mm2
Message-ID: <20060915215042.GA15175@suse.de>
References: <20060912000618.a2e2afc0.akpm@osdl.org> <6bffcb0e0609140411j46c20757r6eced82b53266e0f@mail.gmail.com> <20060914214038.GA32352@suse.de> <6bffcb0e0609141517j4128dd41n1cd21599c51541a2@mail.gmail.com> <20060914223638.GA547@suse.de> <6bffcb0e0609151335wce499b0nb3e39bdc26b4b433@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0609151335wce499b0nb3e39bdc26b4b433@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2006 at 10:35:37PM +0200, Michal Piotrowski wrote:
> Good news, I can't reproduce this bug with CONFIG_USB_MULTITHREAD_PROBE=n.

Great, thanks for letting me know.

> BTW. This might be a problem with CONFIG_PCI_MULTITHREAD_PROBE=y
> http://www.stardust.webpages.pl/files/mm/2.6.18-rc6-mm2/bug.jpg

That looks odd.  What device is your root partition on?  And what is the
"switchroot" stuff being printed out, is that in an initramfs?

thanks,

greg k-h
