Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276424AbSAGQpL>; Mon, 7 Jan 2002 11:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279798AbSAGQpC>; Mon, 7 Jan 2002 11:45:02 -0500
Received: from ns.ithnet.com ([217.64.64.10]:65042 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S276424AbSAGQox>;
	Mon, 7 Jan 2002 11:44:53 -0500
Date: Mon, 7 Jan 2002 17:44:50 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: christian e <cej@ti.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swapping,any updates ?? Just wasted money on mem upgrade performance still suck :-(
Message-Id: <20020107174450.5d20d2ad.skraw@ithnet.com>
In-Reply-To: <3C396B45.6040702@ti.com>
In-Reply-To: <3C386DC9.307@ti.com>
	<20020106170204.7e04e81f.skraw@ithnet.com>
	<3C396B45.6040702@ti.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Jan 2002 10:32:53 +0100
christian e <cej@ti.com> wrote:

> Stephan von Krawczynski wrote:
> 
> 
> > Besides the fact I couldn't identify the kernel version from your mail, I
would> > try:
> > 
> > 1) Turn off swap, then
> > 2) Use 2.4.17 with patch I send you off LKML.
> > 
> > Then give us a hint if things got better.
>
> Sorry forgot that.Currently running 2.4.17-mjc1.

Please try a stock 2.4.17 (with the patch), otherwise we will have no idea what
is going on.

> Turning off swap is apparently not an option 'cause now VMware won't run 
> anymore (really a swap happy app if I ever saw one :o) I get this error 
> when starting to log on to my virtual Windows XP Pro:
> 
> AIO: unexpected loss of channel ide0:0 (thread ide 0:0)
> 
> and turning swap back on it runs with no problems..*sigh*

Uh, this is no good. How much mem does your XP need? I can't really believe you
need more than the 512 MB you have to get this config running. Really: please
try stock kernel with patch.

> Can I make a RAM drive and then use that for swap ??Will the patch you 
> sent me work with swap turned on ??

Yes, it will work of course. But we would like to see this config without swap
running too, won't we?

> For info my system:
> 
> Dell latitude cpx j650GT,650 MHz P3
> 512 MB mem
> 12 GB hdd
> 3com 3c575ct pcmcia NIC

Nice box. Must work somehow.

Regards,
Stephan


