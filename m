Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311685AbSCNRD7>; Thu, 14 Mar 2002 12:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311684AbSCNRDr>; Thu, 14 Mar 2002 12:03:47 -0500
Received: from angband.namesys.com ([212.16.7.85]:31106 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S311683AbSCNRDi>; Thu, 14 Mar 2002 12:03:38 -0500
Date: Thu, 14 Mar 2002 20:03:37 +0300
From: Oleg Drokin <green@namesys.com>
To: Alex Walker <alex@x3ja.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.5.6 and 2.5.7-pre1 - reiserfs?
Message-ID: <20020314200337.A2186@namesys.com>
In-Reply-To: <20020314162009.F9664@x3ja.co.uk> <20020314192916.A1929@namesys.com> <20020314170123.G9664@x3ja.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020314170123.G9664@x3ja.co.uk>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Mar 14, 2002 at 05:01:23PM +0000, Alex Walker wrote:

> Whilst I'm here... Is there a neat way to convert your root system from
> 3.5 to 3.6?  I tried "mount -o remount,conv /" which gave no errors, but
> didn't actually convert it.  I also tried adding conv to the options in
> /etc/fstab, but to similar effect...  Do I have to copy to a different
> partition with a 3.6 format and use that as my root to do it?

I think you need to pass "rootflags=conv" option to your kernel.
That should work. Esp. if you do not use any kind of initrd.

Bye,
    Oleg
