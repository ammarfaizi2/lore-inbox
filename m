Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbTIYU2D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 16:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbTIYU2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 16:28:03 -0400
Received: from tantale.fifi.org ([216.27.190.146]:20622 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S261845AbTIYU17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 16:27:59 -0400
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in vanilla 2.4.22 serial-usb driver
References: <87llsdy01v.fsf@ceramic.fifi.org>
	<20030925185039.GB29088@kroah.com>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 25 Sep 2003 13:27:57 -0700
In-Reply-To: <20030925185039.GB29088@kroah.com>
Message-ID: <87eky4hauq.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> On Wed, Sep 24, 2003 at 09:17:00PM -0700, Philippe Troin wrote:
> > This happened at the end of a Palm sync.
> > The machine went on, but USB is not irresponsive to USB attach/detach
> > since khubd is dead. The USB low-level driver is UHCI_ALT, compiled
> > in-kernel.
> 
> This should be fixed in the 2.4.23-pre tree now.  If you want, you can
> try applying the patch at:
> 	http://www.kernel.org/pub/linux/kernel/people/gregkh/usb/2.4/usb-serial-02-2.4.23-pre3.patch
> if you don't want the whole -pre tree.

That's what I had figured out from looking at the 23rcX changelogs and
diffs.

> > BTW, is there any way to restart khubd without rebooting?
> 
> Nope, sorry.

Are there any technical reasons behind that, or that just that it is
not implemented?
 
> Let me know if this doesn't solve the problem for you.

I won't be able to test until later today, but I will let you know.

Thanks,
Phil.
