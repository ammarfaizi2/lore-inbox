Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268382AbRG3Voh>; Mon, 30 Jul 2001 17:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268446AbRG3Vo1>; Mon, 30 Jul 2001 17:44:27 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:1036 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S268382AbRG3VoS>; Mon, 30 Jul 2001 17:44:18 -0400
Message-ID: <3B65D538.17FEA0E0@namesys.com>
Date: Tue, 31 Jul 2001 01:44:24 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Christoph Hellwig <hch@caldera.de>
CC: linux-kernel@vger.kernel.org, Vitaly Fertman <vitaly@namesys.com>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <200107281645.f6SGjA620666@ns.caldera.de> <3B653211.FD28320@namesys.com> <20010730210644.A5488@caldera.de> <3B65C3D4.FF8EB12D@namesys.com> <20010730224930.A18311@caldera.de> <3B65CC07.24E3EF4C@namesys.com> <20010730232956.A20969@caldera.de>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Christoph Hellwig wrote:
> 
> On Tue, Jul 31, 2001 at 01:05:11AM +0400, Hans Reiser wrote:
> > There is nothing like a distro maintainer
> 
>         [NOTE:  I do not maintain the Caldera kernel RPM, but I was
>                 involved in the decision to turn reiserfs debugging on]
> 
> > overriding the design decisions made
> > by the lead architect of a package, not believing that said architect knows what
> > the fuck he is doing.
> 
> Reiserfs lately had a lot of stability issues, reports of data corruption
> and as you said before you don't considere the reiserfs version in 2.4.2-ac
> stable yourself.
> 
> The averange user will not blame you if he loses data through a problem
> in reiserfs but the distribtuion, even if this filesystem is clearly
> marked unsupported.
> 
> >
> > We will make this unusable by you from this point onwards.
> >
> 
> I do not see the debug kernel removed from the official kernel tree
> before reiserfs has proven known stable.
> 
> Of course there is still the option of CONFIG_REISERFS_FS=n if you
> intentionally want to make your filesystem less acceptable..
> 
>         Christoph
> 
> --
> Of course it doesn't work. We've performed a software upgrade.

We'd rather be off, than have debug on.  Debug is not designed to be on, unless
you are debugging.  Most users don't know that you have turned debug on.  They
just think ReiserFS isn't as fast as their SuSE using friends say it is.  We
will make sure users know that their distro has turned debug on.

Hans
