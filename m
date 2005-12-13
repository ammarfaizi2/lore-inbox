Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030242AbVLMW5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbVLMW5x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030336AbVLMW5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:57:52 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:8121 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030242AbVLMW5r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:57:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tY+Qi8NDXpQ0JTMoKW6g9Ib+ObtRWVwUGpa64AqfRcHc65kgVX3ya9boGTiq0FG3aArzVpsCFoHGhgqV6ixsR1xy18ddRH66X04EOS7vv9mtYyLfdqmRsD/b69e1tIRncW6RjOhc9p25m29ELSXw016yBO4wmv3Vxx/FRvPH0pQ=
Message-ID: <808c8e9d0512131457k6f88e893p27e0f931741ed1fe@mail.gmail.com>
Date: Tue, 13 Dec 2005 16:57:45 -0600
From: Ben Gardner <gardner.ben@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] i386: GPIO driver for AMD CS5535/CS5536
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051213142410.5f5f2bae.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <808c8e9d0512130904j5f202f7cwe0d195efb12afad0@mail.gmail.com>
	 <20051213142410.5f5f2bae.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/05, Andrew Morton <akpm@osdl.org> wrote:
> Ben Gardner <gardner.ben@gmail.com> wrote:
> >
> >  A simple driver for the CS5535 and CS5536 that allows a user-space
> >  program to manipulate GPIO pins.
> >  The CS5535/CS5536 chips are Geode processor companion devices.
>
> Should CONFIG_CS5535_GPIO depend on X86 or X86_32?
>

I think it should depend on X86_32.
Would you like me to send you a -fix patch or would you rather take care of it?

Thanks,
Ben
