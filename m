Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262284AbTCPBz2>; Sat, 15 Mar 2003 20:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262292AbTCPBz1>; Sat, 15 Mar 2003 20:55:27 -0500
Received: from riffraff.plig.net ([195.40.6.40]:55557 "EHLO riffraff.plig.net")
	by vger.kernel.org with ESMTP id <S262284AbTCPBz1>;
	Sat, 15 Mar 2003 20:55:27 -0500
Date: Sun, 16 Mar 2003 02:06:17 +0000
From: Adam Spiers <arch-users@adamspiers.org>
To: arch-users@lists.fifthvision.net, linux-kernel@vger.kernel.org
Subject: Re: [arch-users] Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <20030316020617.GA5594@riffraff.plig.net>
Reply-To: Adam Spiers <arch-users@adamspiers.org>
Mail-Followup-To: arch-users@lists.fifthvision.net,
	linux-kernel@vger.kernel.org
References: <200303151621.h2FGLgaD003246@eeyore.valparaiso.cl> <20030315212205.CDE923D979@mx01.nexgo.de> <1047765218.9619.124.camel@lan1> <20030316001840.GB11761@pasky.ji.cz> <200303160144.RAA04331@emf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303160144.RAA04331@emf.net>
User-Agent: Mutt/1.4i
X-URL: http://tigerpig.org/
X-OS: RedHat Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Lord (lord@emf.net) wrote:
>   `+'-named log message files _are_ going to change to something more
>   vi-friendly.  My bad.  I'm both an emacs user and a
>   unix-traditionalist.  I didn't initially notice the problem and my
>   reaction on hearing about it was "Well, vi is broken" -- but as a
>   practical matter, arch does need to change in that area.

Not that you need any more prodding on this direction, but it's worth
noting that both more(1) and less(1) suffer from this problem too.

  $ touch +foo
  $ more +foo
  usage: more [-dflpcsu] [+linenum | +/pattern] name1 name2 ...
  $ less +foo
  Missing filename ("less --help" for help)
