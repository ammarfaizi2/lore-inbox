Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317816AbSHLKfr>; Mon, 12 Aug 2002 06:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317817AbSHLKfr>; Mon, 12 Aug 2002 06:35:47 -0400
Received: from mail2.alphalink.com.au ([202.161.124.58]:29788 "EHLO
	mail2.alphalink.com.au") by vger.kernel.org with ESMTP
	id <S317816AbSHLKfq>; Mon, 12 Aug 2002 06:35:46 -0400
Message-ID: <3D57902B.A84C353C@alphalink.com.au>
Date: Mon, 12 Aug 2002 20:38:35 +1000
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd.
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdkfb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Schwab <schwab@suse.de>
CC: Peter Samuelson <peter@cadcamlab.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] [patch] config language dep_* enhancements
References: <20020808151432.GD380@cadcamlab.org>
		<Pine.LNX.4.44.0208081142390.23063-100000@chaos.physics.uiowa.edu>
		<20020808164742.GA5780@cadcamlab.org>
		<20020809041543.GA4818@cadcamlab.org>
		<3D53D50D.7FA48644@alphalink.com.au> <jey9bg2gax.fsf@sykes.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab wrote:
> 
> |> > +         case "$arg" in
> |> > +           y|m|n) ;;
> |> > +           *) arg=$(eval echo \$$arg) ;;
> |>
> |> Don't you want to check at this point that arg starts with CONFIG_?
> |> Also, how about quoting \$$arg  ?
> 
> The Right Way to write that is like this, assuming that $arg has already
> been verified to be a valid identifier:

Yes, assuming that happens...

>           eval arg=\$$arg
> 
> No need for further quoting.

you're right.

Greg.
-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.     - Roger Sandall, The Age, 28Sep2001.
