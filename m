Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311661AbSCTPbN>; Wed, 20 Mar 2002 10:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311652AbSCTPbE>; Wed, 20 Mar 2002 10:31:04 -0500
Received: from firewall.embl-grenoble.fr ([193.49.43.1]:21724 "HELO
	out.esrf.fr") by vger.kernel.org with SMTP id <S311653AbSCTPay>;
	Wed, 20 Mar 2002 10:30:54 -0500
Date: Wed, 20 Mar 2002 16:30:36 +0100
From: Samuel Maftoul <maftoul@esrf.fr>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: make rpm is not documented
Message-ID: <20020320163036.C22220@pcmaftoul.esrf.fr>
In-Reply-To: <20020320154100.D21789@pcmaftoul.esrf.fr> <E16nhv9-0002XX-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2002 at 03:22:35PM +0000, Alan Cox wrote:
> > Second stuff, make rpm don't work for me on suse's kernel.
> 
> Ask SuSE 8)
> 
> > Didn't yet watched what is the problem, but seems to be related with
> > EXTRAVERSION or something like this.
> 
> At least some versions of the script didnt like multiple '-' symbols. 
> Gerald Britton fixed this for 2.4.18
I'm using unstable suse kernel wich is merged from 1st March up to
2.4.19pre1aa
The patch don't seem to work , but I won't bother you with this stuff as
this is some specific suse Makefile ( EXTRAVERSION is set to nothing but
it has another way to fill it , later in their Makefile )
> Basically the thing works with
> 
> make config/menuconfig/xconfig
> if you use make menu/xconfig then run make oldconfig (I dont trust xconfig..)
Neither I  ;-)
> make rpm
> 
> [wait.. wait.. wait.. ]
> 
> rpm --install
> 
> add to lilo.conf
> 
> enjoy
        Sam
PS: Thanks for answering
