Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269687AbRHIHD4>; Thu, 9 Aug 2001 03:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269707AbRHIHDr>; Thu, 9 Aug 2001 03:03:47 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:7935 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S269687AbRHIHDh>;
	Thu, 9 Aug 2001 03:03:37 -0400
Date: Thu, 9 Aug 2001 17:02:46 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Monniaux <monniaux@di.ens.fr>
Cc: linux-kernel@vger.kernel.org, sfr@canb.auug.org.au
Subject: Re: APM poweroff under Linux 2.4.7 / 2.4.2 RH 7.1
Message-Id: <20010809170246.04c44c35.sfr@canb.auug.org.au>
In-Reply-To: <20010806230335.A2473@picsou.chatons>
In-Reply-To: <20010806230335.A2473@picsou.chatons>
X-Mailer: Sylpheed version 0.5.1 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 6 Aug 2001 23:03:35 +0200 David Monniaux wrote:
> 
> I have an Athlon on an ASUS A7V133.
> This machine powers off perfectly using a stock RedHat 7.1 kernel (2.4.2).
> However, it refuses to power off with 2.4.7, with all APM options set
> correctly (including power off in real mode).
> 
> Now for the funny part: copying the 2.4.2 apm.c to the 2.4.7 and
> recompiling yielded a working poweroff. So *something* has been broken
> between 2.4.2 and 2.4.7 with APM poweroff. :-)

So, is this a pristine 2.4.2?  Or is it a RH patched one?  I have just
looked at the differences in arch/i386/kernel/apm.c between 2.4.2 and
2.4.7.  The only differences are in comments and to allow one more
kernel command line option. i.e. there is nothing that should make APM
behave differently.

Could you send me a diff between the two versions of apm.c, please?

Cheers,
Stephen Rothwell
IBM Linux Technology Centre, Canberra
