Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbTIYWb3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 18:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbTIYWb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 18:31:29 -0400
Received: from tantale.fifi.org ([216.27.190.146]:5008 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S262004AbTIYWb1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 18:31:27 -0400
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in vanilla 2.4.22 serial-usb driver
References: <87llsdy01v.fsf@ceramic.fifi.org>
	<20030925185039.GB29088@kroah.com> <87eky4hauq.fsf@ceramic.fifi.org>
	<20030925210104.GB29680@kroah.com>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 25 Sep 2003 15:31:25 -0700
In-Reply-To: <20030925210104.GB29680@kroah.com>
Message-ID: <87ad8sh54y.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> On Thu, Sep 25, 2003 at 01:27:57PM -0700, Philippe Troin wrote:
> > > > BTW, is there any way to restart khubd without rebooting?
> > > 
> > > Nope, sorry.
> > 
> > Are there any technical reasons behind that, or that just that it is
> > not implemented?
> 
> It's a bit hard to restart a kernel thread that is oopsed :)

Yes, but still, with a completely modular USB subsystem, removing all
the modules and reinsrting them (when possible) restarts khubd... So
if it is possible with modules, it ought to be possible with
monolithic USB...

Phil.
