Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135331AbREBOpU>; Wed, 2 May 2001 10:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135535AbREBOpK>; Wed, 2 May 2001 10:45:10 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:14744 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S135331AbREBOoy>; Wed, 2 May 2001 10:44:54 -0400
Date: Wed, 2 May 2001 16:44:51 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Jeff Dike <jdike@karaya.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Debuggers, KDB or KGDB?
Message-ID: <20010502164451.L706@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20010501113758.D3305@nightmaster.csn.tu-chemnitz.de> <200105011522.KAA01925@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200105011522.KAA01925@ccure.karaya.com>; from jdike@karaya.com on Tue, May 01, 2001 at 10:22:14AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2001 at 10:22:14AM -0500, Jeff Dike wrote:
> ingo.oeser@informatik.tu-chemnitz.de said:
> > Basically you could add support for ALL generic subsystems, that
> > support dummy hardware, like SCSI and ISDN for example.
> > Is that planned or do I suggest sth. stupid here? ;-) 
> 
> Neither.  I know squat about hardware, so I had no idea that SCSI and ISDN 
> would be easy to do from UML.
> 
> If the SCSI and ISDN people want to produce appropriate UML drivers, I take 
> patches :-)

Everything is there. SCSI and ISDN have the equivalent devices of the
"lo" driver for the networking layer. Or the equivalent of
tun/tap devices for the ethernet layer.

It just have to be an config.in option in UML and every other
adapters switched off.

The problem is: I still do not really get how UML really works.
Many of the mapping rules (Kernel machanism on normal arch ->
UML) are not quite clear to me.

Is there a paper or sth. like that describing the design a bit
more in detail? I only found usage papers on the user-mode-linux
home page.

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
