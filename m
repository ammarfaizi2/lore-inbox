Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbWAWFqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWAWFqa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 00:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWAWFqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 00:46:30 -0500
Received: from relay01.pair.com ([209.68.5.15]:45071 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S964807AbWAWFq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 00:46:29 -0500
X-pair-Authenticated: 67.163.102.102
From: Chase Venters <chase.venters@clientec.com>
To: Michael Loftis <mloftis@wgops.com>
Subject: Re: [RFC] VM: I have a dream...
Date: Sun, 22 Jan 2006 23:46:02 -0600
User-Agent: KMail/1.9
Cc: "Barry K. Nathan" <barryn@pobox.com>, Al Boldi <a1426z@gawab.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <200601212108.41269.a1426z@gawab.com> <986ed62e0601221155x6a57e353vf14db02cc219c09@mail.gmail.com> <E3C35184F807ADEC2AD9E182@dhcp-2-206.wgops.com>
In-Reply-To: <E3C35184F807ADEC2AD9E182@dhcp-2-206.wgops.com>
Organization: Clientec, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601222346.24781.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 January 2006 23:23, Michael Loftis wrote:
> --On January 22, 2006 11:55:37 AM -0800 "Barry K. Nathan"
>
> <barryn@pobox.com> wrote:
> > On 1/21/06, Al Boldi <a1426z@gawab.com> wrote:
> >> A long time ago, when i was a kid, I had dream. It went like this:
> >
> > [snip]
> >
> > FWIW, Mac OS X is one step closer to your vision than the typical
> > Linux distribution: It has a directory for swapfiles -- /var/vm -- and
> > it creates new swapfiles there as needed. (It used to be that each
> > swapfile would be 80MB, but the iMac next to me just has a single 64MB
> > swapfile, so maybe Mac OS 10.4 does something different now.)

Just as a curiosity... does anyone have any guesses as to the runtime 
performance cost of hosting one or more swap files (which thanks to on demand 
creation and growth are presumably built of blocks scattered around the disk) 
versus having one or more simple contiguous swap partitions?

I think it's probably a given that swap partitions are better; I'm just 
curious how much better they might actually be.

Cheers,
Chase
