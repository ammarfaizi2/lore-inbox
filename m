Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263385AbUJ2Ovt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263385AbUJ2Ovt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 10:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263360AbUJ2Ot2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 10:49:28 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:13075 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263377AbUJ2Oq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 10:46:57 -0400
Date: Fri, 29 Oct 2004 16:46:25 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Tonnerre <tonnerre@thundrix.ch>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Erik Andersen <andersen@codepoet.org>, uclibc@uclibc.org
Subject: Re: The naming wars continue...
Message-ID: <20041029144625.GN6677@stusta.de>
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org> <20041026203137.GB10119@thundrix.ch> <417F2251.7010404@zytor.com> <200410271133.25701.vda@port.imtp.ilyichevsk.odessa.ua> <20041027154828.GA21160@thundrix.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041027154828.GA21160@thundrix.ch>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 05:48:28PM +0200, Tonnerre wrote:
> Salut,
> 
> On Wed, Oct 27, 2004 at 11:33:25AM +0300, Denis Vlasenko wrote:
> > Why there is any distinction between, say, gcc and X?
> > KDE and Midnight Commander? etc... Why some of them go
> > to /opt while others are spread across dozen of dirs?
> 
> Well.
> 
> FHS specifies that everything needed  to boot the system should got to
> /bin  and /sbin. The  base system  (build system,  etc.) should  go to
> /usr. The rest should be /opt/itspackagename.
>...


The last phrase isn't exactly correct.


The FHS says:
  Distributions may install software in /opt, but must not modify or 
  delete software installed by the local system administrator without 
  the assent of the local system administrator.


E.g. Debian installs nothing under /opt .


> 			    Tonnerre

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

