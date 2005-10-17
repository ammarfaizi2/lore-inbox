Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbVJQVZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbVJQVZq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 17:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbVJQVZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 17:25:46 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:18344 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932321AbVJQVZp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 17:25:45 -0400
Date: Mon, 17 Oct 2005 23:27:52 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc4-mm1 dead in early boot
Message-ID: <20051017212752.GA30457@aitel.hist.no>
References: <20051016154108.25735ee3.akpm@osdl.org> <20051017210609.GA30116@aitel.hist.no> <20051017140906.0771f797.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051017140906.0771f797.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 02:09:06PM -0700, Andrew Morton wrote:
> Helge Hafting <helgehaf@aitel.hist.no> wrote:
> >
> > This one gets me a penguin on the framebuffer, and then dies
> > with no further textual output.  
> > numlock leds were working, and I could reboot with sysrq.
> 
> Can we get anything useful out of sysrq-p and sysrq-t?
> 
Nothing displayed - the penguin just sits there.
Seems he's not hung, merely waiting for something, even
ctrl+alt+del does a reboot.

> Also, adding initcall_debug to the boot command line might help.
> 
Didn't seem to help.  I get some text _before_ the penguin
appears, thre last I was able to read before the blackout
and the penguin was something about USB storage.

I had both vgacon and fbcon compiled in.  I am retrying with
vgacon only, no framebuffer support, to see if it is a framebuffer
or fbcon problem.  This setup worked with 2.6.14-rc3 though.

Helge Hafting
