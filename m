Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267296AbSLKUdN>; Wed, 11 Dec 2002 15:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267297AbSLKUdN>; Wed, 11 Dec 2002 15:33:13 -0500
Received: from mail.ithnet.com ([217.64.64.8]:53764 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S267296AbSLKUdM>;
	Wed, 11 Dec 2002 15:33:12 -0500
Date: Wed, 11 Dec 2002 21:27:34 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: Bug Report 2.4.20: Interrupt sharing bogus
Message-Id: <20021211212734.5429bfee.skraw@ithnet.com>
In-Reply-To: <1039639993.18587.19.camel@irongate.swansea.linux.org.uk>
References: <20021211195501.7f6dff35.skraw@ithnet.com>
	<1039635955.18587.12.camel@irongate.swansea.linux.org.uk>
	<20021211203403.130fc724.skraw@ithnet.com>
	<1039639993.18587.19.camel@irongate.swansea.linux.org.uk>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Dec 2002 20:53:13 +0000
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Wed, 2002-12-11 at 19:34, Stephan von Krawczynski wrote:
> 
> > Is this sufficient? This is from my tried (bogus) setup:
> > 
> > CONFIG_X86_GOOD_APIC=y
> > # CONFIG_X86_UP_APIC is not set
> > # CONFIG_X86_UP_IOAPIC is not set
> 
> It is

Why does it freeze then with this config? I doubt it has ultimately to do with
the 4-port card being of "4-port nature". I can use every of its ports that
does not share interrupt with another device. As soon as I share I get busted.
As I told the driver used for ethernet doesn't seem to matter as tulip and
sundance show the same effect.
I am very interested in solving this somehow having five pieces of these
boards...
What can I do? Is there any documentation needed from SIS, or anything else?
-- 
Regards,
Stephan
