Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269791AbUHZXxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269791AbUHZXxd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 19:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269762AbUHZXso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 19:48:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:4224 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269633AbUHZXmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 19:42:01 -0400
Date: Thu, 26 Aug 2004 16:40:10 -0700
From: Greg KH <greg@kroah.com>
To: Wouter Van Hemel <wouter-kernel@fort-knox.rave.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.8 pwc patches and counterpatches
Message-ID: <20040826234010.GA22046@kroah.com>
References: <33193.151.37.215.244.1093530681.squirrel@webmail.azzurra.org> <Pine.LNX.4.61.0408261948480.555@senta.theria.org> <20040826190701.GA13310@kroah.com> <Pine.LNX.4.61.0408270106440.8658@senta.theria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0408270106440.8658@senta.theria.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 01:35:01AM +0200, Wouter Van Hemel wrote:
> On Thu, 26 Aug 2004, Greg KH wrote:
> 
> >It's not that kind of decision.  The fact is that the hook is illegal,
> >so I am forced to remove it.  End of story.
> >
> 
> Define 'illegal'.

Having a hook in the kernel (in GPLed code) for the explicit purpose of
allowing a binary module is not allowed.  Go read Linus's statements
about this in the archives.

> Philips supports the linux driver, for now in it's partial binary form. I 
> bought the webcam. I also bought the drivers (for windows) that came with 
> the webcam. I have every right to have my paid-for product working.

Then talk to Phillips, or Nemosoft.  I didn't rip the driver out of the
kernel, only the hook.  Nemosoft asked that the driver be riped out, and
that's his option.

> Binary code is not illegal. Undesirable, maybe. But not illegal. It's not 
> even included in the kernel code. Only a hook, and it's not even a forced 
> dependency.

Great, then use the version I did without the hook.  That's fine with
me.

thanks,

greg k-h
