Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312405AbSCZSxw>; Tue, 26 Mar 2002 13:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312443AbSCZSxn>; Tue, 26 Mar 2002 13:53:43 -0500
Received: from 209-VALL-X7.libre.retevision.es ([62.83.213.209]:55815 "EHLO
	ragnar-hojland.com") by vger.kernel.org with ESMTP
	id <S312405AbSCZSxi>; Tue, 26 Mar 2002 13:53:38 -0500
Date: Tue, 26 Mar 2002 19:52:45 +0100
From: Ragnar Hojland Espinosa <ragnar@jazzfree.com>
To: Frank Cornelis <fcorneli@elis.rug.ac.be>
Cc: linux-kernel@vger.kernel.org, Frank.Cornelis@elis.rug.ac.be
Subject: Re: realtime processes and CD-ROM
Message-ID: <20020326195245.B2539@ragnar-hojland.com>
In-Reply-To: <Pine.LNX.4.44.0203251716140.24395-100000@trappist.elis.rug.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://lightside.eresmas.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2002 at 05:25:50PM +0100, Frank Cornelis wrote:
> The MP3 player XMMS has the option of making it a realtime process.
> But even after doing so, the music sometimes blocks. This is when my CDROM 
> is being accessed when it is not spinning anymore (spin-up time).
> Would it be very hard to reprogram the linux kernel in such a way that
> certain devices can't be turned off when realtime processes access these
> devices? These devices would include CDROM players, harddisks.
> Please note that I'm not looking for a way to (globally) disable the 
> spinning off of my CDROM player when it's in use. Only when realtime 
> processes access these devices the spinning of should be disabled.
> If anyone is programming on something like described above please let me 
> know.

XMMS could have a flag to set spinning with CDROMSETSPINDOWN, which should
do what you are looking for.

____/|  Ragnar Højland      Freedom - Linux - OpenGL |    Brainbench MVP
\ o.O|  PGP94C4B2F0D27DE025BE2302C104B78C56 B72F0822 | for Unix Programming
 =(_)=  "Thou shalt not follow the NULL pointer for  | (www.brainbench.com)
   U     chaos and madness await thee at its end."      [15 pend. Mar 10]
