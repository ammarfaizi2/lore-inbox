Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265617AbTF3Rps (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 13:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265645AbTF3Rps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 13:45:48 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:64993 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265617AbTF3Rpn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 13:45:43 -0400
Date: Mon, 30 Jun 2003 11:00:02 -0700
From: Greg KH <greg@kroah.com>
To: martin f krafft <madduck@madduck.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: restarting a kernel thread
Message-ID: <20030630180002.GA25461@kroah.com>
References: <20030630171033.GA27703@diamond.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030630171033.GA27703@diamond.madduck.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 30, 2003 at 07:10:33PM +0200, martin f krafft wrote:
> i am doing some USB development these days and just managed to crash
> khubd:
> 
>   kernel:  <6>note: khubd[9] exited with preempt_count 1
> 
> the system seems happy still, USB is not working anymore, though.
> 
> I have USB support built into the kernel, and a custom driver
> written as a module.
> 
> Restarting would fix the problem and get USB back into operation,
> but I am wondering if there is a way to restart the khubd kernel
> thread manually. Is there?

Not really, sorry.  Make usbcore a module and then just reload it will
work.

> I am soon going to switch to UML for this kind of development...

For USB development?  Ok...please send us the patches that get USB
support working under UML as others have wanted to do this for quite
some time :)

Oh, what kind of driver are you working on?

thanks,

greg k-h
