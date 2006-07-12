Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbWGLRpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWGLRpd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 13:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWGLRpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 13:45:33 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:59656 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932205AbWGLRpc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 13:45:32 -0400
Date: Wed, 12 Jul 2006 13:45:31 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: ray-gmail@madrabbit.org
cc: Dave Jones <davej@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       David Brownell <david-b@pacbell.net>
Subject: Re: annoying frequent overcurrent messages.
In-Reply-To: <2c0942db0607121034w170b4b24l928773fa37b3705e@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.0607121344420.6111-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2006, Ray Lee wrote:

> > > For the syslog spamming, you could jus emit the message once when the
> > > state is first noticed, then emit a everything good message when it
> > > clears up. There's no need to log it repeatedly during the problem
> > > period.
> >
> > That's almost exactly how the driver behaves currently -- the message is
> > printed just once when the state is first noticed.  Nothing is printed
> > when the state is cleared, and nothing gets printed repeatedly during the
> > problem period.  But then the problem recurs very quickly.
> 
> Then the logging of the 'all cleared up' message would be better if it
> had a bit of hysteresis to it -- the good state is noticed, but don't
> log it as such until it hangs out there for a while and has had a
> chance to quiesce.

You didn't read what I wrote -- there _is_ no "all cleared up" message.

Alan Stern

