Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132822AbRDQTLq>; Tue, 17 Apr 2001 15:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132824AbRDQTLg>; Tue, 17 Apr 2001 15:11:36 -0400
Received: from cpe-66-1-218-52.fl.sprintbbd.net ([66.1.218.52]:30990 "EHLO
	mail.compro.net") by vger.kernel.org with ESMTP id <S132822AbRDQTL1>;
	Tue, 17 Apr 2001 15:11:27 -0400
Message-ID: <3ADC957A.4EC55BFA@compro.net>
Date: Tue, 17 Apr 2001 15:11:54 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: amiga affs support broken in 2.4.x kernels??
In-Reply-To: <3AD59EB9.35F3A535@compro.net> <3AD9FEDD.2B636582@linux-m68k.org> <3ADAEA9B.D70DC130@compro.net> <3ADB1837.A0AE3020@linux-m68k.org> <3ADC3262.C97B475@compro.net> <3ADC85A1.4755C87F@linux-m68k.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> 
> Could you try the attached patch? I forgot to initialize a variable
> correctly.
> (I also put a new version at
> http://www.xs4all.nl/~zippel/affs.010417.tar.gz)
> 
> > I beleive the filesystem is ffs
> > but not exactly sure. How do I tell?
> 
> It's printed if you mount with '-overbose', but it shouldn't be needed
> anymore. :)
> 
> bye, Roman
> 
>   ------------------------------------------------------------------------
>                 Name: affs.diff
>    affs.diff    Type: Plain Text (text/plain)
>             Encoding: 7bit
Roman,
 That seems to have done it. I'm now able to mount,read,and write to
affs
file systems. With an scsi zip drive with 3 affs partitions on it and an
affs hardfile(loop) that I use with UAE occasionally. Looks good to me.
I'll be using this functionality quite a bit so I'll notify you of any
anomalies if it's ok. Thank you for your efforts.

Regards
Mark Hounschell
markh@compro.net
