Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265418AbRFVN5V>; Fri, 22 Jun 2001 09:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265417AbRFVN5L>; Fri, 22 Jun 2001 09:57:11 -0400
Received: from t2.redhat.com ([199.183.24.243]:64252 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S265415AbRFVN5C>; Fri, 22 Jun 2001 09:57:02 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010622094934.A13075@thyrsus.com> 
In-Reply-To: <20010622094934.A13075@thyrsus.com>  <20010621160309.A6744@thyrsus.com> <20010621154934.A6582@thyrsus.com> <20010621205537.X18978@flint.arm.linux.org.uk> <20010621160309.A6744@thyrsus.com> <7987.993197604@redhat.com> 
To: esr@thyrsus.com
Cc: Russell King <rmk@arm.linux.org.uk>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Missing help entries in 2.4.6pre5 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 22 Jun 2001 14:56:50 +0100
Message-ID: <10604.993218210@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


esr@thyrsus.com said:
>  You're a bit irritated.  That's good.  I *want* people who don't
> write help entries for their configuration symbols to be a bit
> irritated. That way, they might get around to actually doing what they
> ought to.

I wasn't irritated the first time. I sent you a patch which added all the
help entries I'd missed, and thanked you for checking. To be honest, I'd
actually been counting on you to do that for me and catch the ones I'd 
missed.

The irritation only happened because you seem to have ignored the remainder
of my original response and patch - which explained the status of the Ocelot
and XScale options, and which removed the other offending option from
Config.in completely. I'd removed the corresponding code before syncing up
with Linus because it wanted rewriting before it could be submitted, just
forgotten to remove the config option for it.

I'm already rejecting patches which add new config entries but don't add 
the corresponding help text. What more do you want?

--
dwmw2


