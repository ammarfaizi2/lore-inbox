Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265436AbRFVO6b>; Fri, 22 Jun 2001 10:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265437AbRFVO6V>; Fri, 22 Jun 2001 10:58:21 -0400
Received: from zeus.kernel.org ([209.10.41.242]:7569 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S265436AbRFVO6N>;
	Fri, 22 Jun 2001 10:58:13 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010622102458.A13435@thyrsus.com> 
In-Reply-To: <20010622102458.A13435@thyrsus.com>  <20010622094934.A13075@thyrsus.com> <20010621160309.A6744@thyrsus.com> <20010621154934.A6582@thyrsus.com> <20010621205537.X18978@flint.arm.linux.org.uk> <20010621160309.A6744@thyrsus.com> <7987.993197604@redhat.com> <20010622094934.A13075@thyrsus.com> <10604.993218210@redhat.com> 
To: esr@thyrsus.com
Cc: Russell King <rmk@arm.linux.org.uk>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Missing help entries in 2.4.6pre5 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 22 Jun 2001 15:54:53 +0100
Message-ID: <18157.993221693@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


esr@thyrsus.com said:
>  From the person(s) reponsible for the missing symbols, I want
> documentation.  The problem is that, lacking a detailed database of
> who is responsible for what, I don't know how to prod each of the
> people I really want to supplicate/irritate without having you see it
> also.

In fact, in the case of the Ocelot and IQ80310, I _am_ the person 
responsible for their visibility in Linus' tree at the moment, so you
shouldn't be hassling the owners of those symbols.

I put the references there, as guards for drivers which are specific to
those platforms, although the rest of the support for those platforms hasn't
yet been merged into Linus' tree.

Until such time as the {Strong,}ARM and MIPS arch maintainers feed the rest 
of the code to support these platforms to Linus, it's unfair to hassle them
for the documentation. And until that time, it's not strictly necessary 
either, because the user can't even see the options in question, surely?

You could perhaps argue that I shouldn't have sent code to Linus which 
can't yet be enabled and used. If you did, I'd disagree with that.

The VIRTUAL_ER option is also my fault, and will go away shortly - it just
depends on how many times I have to resend the patch to Linus.

--
dwmw2


