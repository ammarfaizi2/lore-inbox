Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265167AbUEYUOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265167AbUEYUOM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 16:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265170AbUEYUOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 16:14:12 -0400
Received: from web13901.mail.yahoo.com ([216.136.175.27]:31092 "HELO
	web13901.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265167AbUEYUOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 16:14:05 -0400
Message-ID: <20040525201404.18259.qmail@web13901.mail.yahoo.com>
X-RocketYMMF: knobi.rm
Date: Tue, 25 May 2004 13:14:04 -0700 (PDT)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: Re: Multicast problems between 2.4.20 and 2.4.21?
To: "David S. Miller" <davem@redhat.com>
Cc: flind@haystack.mit.edu, linux-kernel@vger.kernel.org
In-Reply-To: <20040525125928.444087a4.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- "David S. Miller" <davem@redhat.com> wrote:
> On Tue, 25 May 2004 11:15:10 -0700 (PDT)
> Martin Knoblauch <knobi@knobisoft.de> wrote:
> 
> >   what is the name of the sysctl, and when was it added to 2.4?
> What
> > about 2.6.x?
> 
> /proc/sys/net/ipv4/conf/${DEV}/force_igmp_version
> 
> Replace ${DEV} with a specific device name, "default", or "all"
> as desired.
> 
> It got added to 2.4.25 I believe, and yes 2.6.x has it too.
> 
> 

 cool. What value does one put in? Is it just 0/1, or do you specify
the protocol version you want to force?

Cheers
Martin


=====
------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
