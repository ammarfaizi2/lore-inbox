Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315874AbSEGP0t>; Tue, 7 May 2002 11:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315873AbSEGP0s>; Tue, 7 May 2002 11:26:48 -0400
Received: from firewall.esrf.fr ([193.49.43.1]:27065 "HELO out.esrf.fr")
	by vger.kernel.org with SMTP id <S315872AbSEGP0q>;
	Tue, 7 May 2002 11:26:46 -0400
Date: Tue, 7 May 2002 17:26:32 +0200
From: Samuel Maftoul <maftoul@esrf.fr>
To: Mickael Bailly <mickael.bailly@trader.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: eepro100: wait_for_cmd_done timeout (2.4.19-pre2/8)
Message-ID: <20020507172632.F3155@pcmaftoul.esrf.fr>
In-Reply-To: <Pine.LNX.4.44.0205071454270.16371-100000@dunlop.admin.ie.alphyra.com> <200205071712.21699.mickael.bailly@trader.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2002 at 05:12:21PM +0200, Mickael Bailly wrote:
> 	Hi,
> 
> We got the same problem with PCI eepro NICs (not onboard) on Dell Poweredge.
I'm on dell's also but not only poweredge
> We got the same error messages
> We tried the alternative 'e100' driver, but without success.
We also did but we get  approximatively with the same message ( no
really the same, but one talking about timeouts)
> We tried on 2.2 kernels (RedHat 6.2), then on 2.4 (RedHat 7.1/7.2): problem 
> still exist.
I didn't tried 2.2
> 
> At last we disabled APIC ( configuration line 'append=noapic' in your 
> lilo.conf configuration file )
I did also but my problem with firewire still exists 
That's the first thing I did, disableapic and noapic ( it's an smp
system so I have no idea what the consequences of this are )

> 
> Now it's working fine since 2 days... need a little more time to validate the 
> change...
> 
> See you
> Mickael
> 
Thanks for the tip.
        Sam
