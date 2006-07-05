Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964953AbWGESEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbWGESEd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 14:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbWGESEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 14:04:32 -0400
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:44418 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964953AbWGESEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 14:04:32 -0400
From: David Brownell <david-b@pacbell.net>
To: "Miles Lane" <miles.lane@gmail.com>
Subject: Re: 2.6.17-mm5 -- netconsole failed to send full trace
Date: Wed, 5 Jul 2006 11:04:29 -0700
User-Agent: KMail/1.7.1
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <a44ae5cd0607030131x745b3106ydd2a4ca086cdf401@mail.gmail.com> <a44ae5cd0607042354s68b38d2bl11d638b282e4c918@mail.gmail.com> <a44ae5cd0607050939w5f6dc131v24c8ffc93e6f8baf@mail.gmail.com>
In-Reply-To: <a44ae5cd0607050939w5f6dc131v24c8ffc93e6f8baf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607051104.29916.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 July 2006 9:39 am, Miles Lane wrote:
> On 7/4/06, Miles Lane <miles.lane@gmail.com> wrote:
> > On 7/4/06, David Brownell <david-b@pacbell.net> wrote:
> > > On Tuesday 04 July 2006 10:22 pm, Miles Lane wrote:
> > >
> > > > > So we have a use-after-free in tasklet_action(), as a consequence of
> > > > > unplugging a USB ethernet adapter.
> > > >
> > > > So far, all the kernels have crashed (back to Ubuntu's 2.6.15).
> > >
> > > Erm, exactly which USB ethernet adapter?  That would seem to be a
> > > critical bit of info that's somehow been omitted...
> > >
> > > If it's the rtl8150 driver, that would be Petko's ...
> >
> > Linksys EtherFast 10/100 Compact Network Adapter (model USB100M).
> > Yes, the rtl8150 driver loads when I insert the adapter.

So you should contact the maintainer of that driver, yes?


> Can someone tell me when the udev/hal support went into the kernel?

Older versions of udev may not work with newer kernels, and vice versa;
I've never taken HAL apart.

