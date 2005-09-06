Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbVIFHP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbVIFHP3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 03:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbVIFHP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 03:15:29 -0400
Received: from smtp.istop.com ([66.11.167.126]:54762 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S932431AbVIFHP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 03:15:28 -0400
From: Daniel Phillips <phillips@istop.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: GFS, what's remainingh
Date: Tue, 6 Sep 2005 03:18:24 -0400
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, Lars Marowsky-Bree <lmb@suse.de>,
       Andi Kleen <ak@suse.de>, linux clustering <linux-cluster@redhat.com>,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org
References: <20050901104620.GA22482@redhat.com> <200509060248.47433.phillips@istop.com> <200509060155.04685.dtor_core@ameritech.net>
In-Reply-To: <200509060155.04685.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509060318.25260.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 September 2005 02:55, Dmitry Torokhov wrote:
> On Tuesday 06 September 2005 01:48, Daniel Phillips wrote:
> > On Tuesday 06 September 2005 01:05, Dmitry Torokhov wrote:
> > > do you think it is a bit premature to dismiss something even without
> > > ever seeing the code?
> >
> > You told me you are using a dlm for a single-node application, is there
> > anything more I need to know?
>
> I would still like to know why you consider it a "sin". On OpenVMS it is
> fast, provides a way of cleaning up...

There is something hard about handling EPIPE?

> and does not introduce single point 
> of failure as it is the case with a daemon. And if we ever want to spread
> the load between 2 boxes we easily can do it.

But you said it runs on an aging Alpha, surely you do not intend to expand it 
to two aging Alphas?  And what makes you think that socket-based 
synchronization keeps you from spreading out the load over multiple boxes?

> Why would I not want to use it?

It is not the right tool for the job from what you have told me.  You want to 
get a few bytes of information from one task to another?  Use a socket, as 
God intended.

Regards,

Daniel
