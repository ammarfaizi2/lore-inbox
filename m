Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267305AbSLKTkQ>; Wed, 11 Dec 2002 14:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267304AbSLKTkP>; Wed, 11 Dec 2002 14:40:15 -0500
Received: from mail.ithnet.com ([217.64.64.8]:4882 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S267305AbSLKTjt>;
	Wed, 11 Dec 2002 14:39:49 -0500
Date: Wed, 11 Dec 2002 20:34:03 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: Bug Report 2.4.20: Interrupt sharing bogus
Message-Id: <20021211203403.130fc724.skraw@ithnet.com>
In-Reply-To: <1039635955.18587.12.camel@irongate.swansea.linux.org.uk>
References: <20021211195501.7f6dff35.skraw@ithnet.com>
	<1039635955.18587.12.camel@irongate.swansea.linux.org.uk>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Dec 2002 19:45:55 +0000
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Wed, 2002-12-11 at 18:55, Stephan von Krawczynski wrote:
> > 4-port ethernet card. For tests I simply copy a lot of files via NFS to the
> > local hd. It always freezes the machine, not always ad-hoc, but within short.
> > I checked with 2.4.19 - same problem.
> > I can test patches on this, no production machine involved. Any hints appreciated.
> 
> Not all systems get on with the 4 ports and bridge stuff. Also make sure
> you have APIC disabled as the SiS io apic has some fun features 2.4
> doesnt yet have workarounds for

Is this sufficient? This is from my tried (bogus) setup:

CONFIG_X86_GOOD_APIC=y
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_UP_IOAPIC is not set

-- 
Regards,
Stephan

