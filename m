Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135635AbREBQmB>; Wed, 2 May 2001 12:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135636AbREBQlv>; Wed, 2 May 2001 12:41:51 -0400
Received: from mnh-1-16.mv.com ([207.22.10.48]:12551 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S135404AbREBQli>;
	Wed, 2 May 2001 12:41:38 -0400
Message-Id: <200105021754.MAA02910@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Debuggers, KDB or KGDB? 
In-Reply-To: Your message of "Wed, 02 May 2001 16:44:51 +0200."
             <20010502164451.L706@nightmaster.csn.tu-chemnitz.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 02 May 2001 12:54:42 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ingo.oeser@informatik.tu-chemnitz.de said:
> Everything is there. SCSI and ISDN have the equivalent devices of the
> "lo" driver for the networking layer. Or the equivalent of tun/tap
> devices for the ethernet layer.

Is this sufficient to do driver development?  TUN/TAP doesn't let me write 
ethernet drivers inside UML.

> It just have to be an config.in option in UML and every other adapters
> switched off.

This is a matter of fiddling the config process.  It might not be easy, but 
there isn't much doubt that it's possible :-)

> The problem is: I still do not really get how UML really works. Many
> of the mapping rules (Kernel machanism on normal arch -> UML) are not
> quite clear to me.
> Is there a paper or sth. like that describing the design a bit more in
> detail? I only found usage papers on the user-mode-linux home page. 

First, have a look at the USB patch at http://user-mode-linux.sourceforge.net/p
atches/uml-hcd-2.4.3.patch

My ALS paper has a description of how UML basically works inside and it's not 
too much out of date - http://user-mode-linux.sourceforge.net/als2000/index.htm
l

Also, my ALS and LCA slides have this sort of information -

http://user-mode-linux.sourceforge.net/slides/als2000/slides.html
http://user-mode-linux.sourceforge.net/slides/lca2001/lca.html

The LCA slides are probably better.  They are from a few months later, and I 
had a longer slot, so I needed more slides.

If you have questions which aren't answered on my site, send me mail.

				Jeff


