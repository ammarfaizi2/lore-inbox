Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278205AbRKHUs4>; Thu, 8 Nov 2001 15:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278269AbRKHUsh>; Thu, 8 Nov 2001 15:48:37 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:55027 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S278205AbRKHUsX>; Thu, 8 Nov 2001 15:48:23 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Andreas Franck <Andreas.Franck@akustik.rwth-aachen.de>
Cc: linux-kernel@vger.kernel.org
Date: Thu, 8 Nov 2001 12:24:25 -0800 (PST)
Subject: Re: Linux-2.4.[10-13]-acX slows down to crawl...
In-Reply-To: <3BEABC6D.F1F4E6D9@akustik.rwth-aachen.de>
Message-ID: <Pine.LNX.4.40.0111081221370.3451-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

with the ipchains compatability module the only problem I have seen is if
you use the redirect target (although looking at the code masqerading may
suffer from the same memory leak), if you are just doing filtering you
will not run into the problem I did.

David Lang



 On Thu, 8 Nov 2001, Andreas Franck
wrote:

> Date: Thu, 08 Nov 2001 18:10:05 +0100
> From: Andreas Franck <Andreas.Franck@akustik.rwth-aachen.de>
> To: David Lang <david.lang@digitalinsight.com>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Linux-2.4.[10-13]-acX slows down to crawl...
>
> Hi David,
>
> >
> > are you useing iptables or ipchains on this box?
> >
> > I see you have them compiled as modules
>
> Yes, I am using the ipchains compatibility module for the
> firewall - I saw your messages regarding performance
> problems with this configuration.
>
> Can this be the cause? Are there any workarounds?
>
> Andreas
>
