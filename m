Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbQKASrT>; Wed, 1 Nov 2000 13:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129937AbQKASrK>; Wed, 1 Nov 2000 13:47:10 -0500
Received: from [216.161.55.93] ([216.161.55.93]:33275 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S129562AbQKASrF>;
	Wed, 1 Nov 2000 13:47:05 -0500
Date: Wed, 1 Nov 2000 10:46:24 -0800
From: Greg KH <greg@wirex.com>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Patch: linux-2.4.0-test10-pre7/drivers/usb/usb.c driver matching bug
Message-ID: <20001101104624.C5526@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>,
	David Brownell <david-b@pacbell.net>,
	linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <200011010342.TAA08318@adam.yggdrasil.com> <013501c0442a$1b08f160$6500000a@brownell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <013501c0442a$1b08f160$6500000a@brownell.org>; from david-b@pacbell.net on Wed, Nov 01, 2000 at 09:35:18AM -0800
X-Operating-System: Linux 2.2.17-immunix (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2000 at 09:35:18AM -0800, David Brownell wrote:
> With the USB driver updates I've already seen, it looks like an
> upcoming 2.4 kernel may no longer need those driver scripts; not
> sure about the 2.2 backports though.

I think one of the "rules" is that the 2.2.x kernel shouldn't require an
upgrade of userspace tools, such as modutils in this case.

So 2.2 would still require the driver scripts if you want to support
dynamic module loading on USB device insertion, but this makes yet
another good reason to move to 2.4 when it is available :)

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
