Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265830AbSKTGai>; Wed, 20 Nov 2002 01:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265844AbSKTGai>; Wed, 20 Nov 2002 01:30:38 -0500
Received: from poup.poupinou.org ([195.101.94.96]:38916 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP
	id <S265830AbSKTGai>; Wed, 20 Nov 2002 01:30:38 -0500
Date: Wed, 20 Nov 2002 07:37:40 +0100
To: Dave Jones <davej@codemonkey.org.uk>, Ducrot Bruno <poup@poupinou.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20 ACPI
Message-ID: <20021120063740.GA707@poup.poupinou.org>
References: <4.3.2.7.2.20021119134830.00b53680@mail.dns-host.com> <20021119130728.GA28759@suse.de> <20021119142731.GF27595@poup.poupinou.org> <20021119183054.GA6771@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021119183054.GA6771@suse.de>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 06:30:54PM +0000, Dave Jones wrote:
> On Tue, Nov 19, 2002 at 03:27:31PM +0100, Ducrot Bruno wrote:
>  > > The newer ACPI code also introduces problems that aren't
>  > > present with the current 2.4.20rc code.
> 
> Got it. This actually isn't a problem with new ACPI code, but
> the addition of the new stack overflow check. It falls flat on
> its face really early if that is enabled.
> 
> The box is totally dead before console is initialised, so I
> don't have backtraces, I'll give that a shot with a serial
> console later. In the meantime, acpi folks should probably
> try testing with CONFIG_DEBUG_STACKOVERFLOW=y to see if they
> hit the same problems I'm getting.
> 

BTW, did you use the sonyip driver?  I am not sure at 100% but
it look like that it request the same irq line than acpi...

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page
