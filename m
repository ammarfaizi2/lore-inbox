Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262864AbUKXVpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbUKXVpG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 16:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbUKXVn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 16:43:28 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:11439 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262866AbUKXVmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 16:42:20 -0500
Subject: Re: Suspend 2 merge: 24/51: Keyboard and serial console hooks.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041124132949.GB13145@infradead.org>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101296414.5805.286.camel@desktop.cunninghams>
	 <20041124132949.GB13145@infradead.org>
Content-Type: text/plain
Message-Id: <1101332321.3895.57.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 25 Nov 2004 08:38:41 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-11-25 at 00:29, Christoph Hellwig wrote:
> On Wed, Nov 24, 2004 at 11:59:02PM +1100, Nigel Cunningham wrote:
> > Here we add simple hooks so that the user can interact with suspend
> > while it is running. (Hmm. The serial console condition could be
> > simplified :>). The hooks allow you to do such things as:
> > 
> > - cancel suspending
> > - change the amount of detail of debugging info shown
> > - change what debugging info is shown
> > - pause the process
> > - single step
> > - toggle rebooting instead of powering down
> 
> And why would we want this?  If the users calls the suspend call
> he surely wants to suspend, right?

Have you ever pressed control-alt-delete/init 0 and then gone "Oh. I
forgot, I wanted to..."? That's why you'd want to be able to cancel
suspending.

The ability to toggle rebooting is helpful because you don't have to
edit a config file/proc entry. You can use one key press to initiate the
suspend, and press 'R' iif you want to reboot (eg for dual booting)
instead of powering down.

The other options are really helpful when testing and debugging, and can
be turned off at compile time.

By the way, thanks for all the feedback.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

