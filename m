Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262244AbSKHPwi>; Fri, 8 Nov 2002 10:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262258AbSKHPwi>; Fri, 8 Nov 2002 10:52:38 -0500
Received: from 24-216-100-96.charter.com ([24.216.100.96]:19075 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id <S262244AbSKHPwh>;
	Fri, 8 Nov 2002 10:52:37 -0500
Date: Fri, 8 Nov 2002 10:59:14 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: installing modules to ($PREFIX)/lib/modules/2.....
Message-ID: <20021108155914.GE1319@rdlg.net>
Mail-Followup-To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20021108154132.GC1319@rdlg.net> <20021108155537.GA1027@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021108155537.GA1027@mars.ravnborg.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Didn't work.  Put them in /lib/modules/2.4.18. (Didn't bite me this time
because my server is on a different kernel but will in the near future).

I cut and past exactly as below.

Thus spake Sam Ravnborg (sam@ravnborg.org):

> Date: Fri, 8 Nov 2002 16:55:37 +0100
> From: Sam Ravnborg <sam@ravnborg.org>
> To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
> 	Linux-Kernel <linux-kernel@vger.kernel.org>
> Subject: Re: installing modules to ($PREFIX)/lib/modules/2.....
> 
> On Fri, Nov 08, 2002 at 10:41:32AM -0500, Robert L. Harris wrote:
> >   I've compiled my kernel and modules but want to install the modules to
> > /tmp/lib/modules/2.4.18 so I can tar that up and move it to the server
> > in question.  Is there a system for doing this built into the kernel
> > compile structure I haven't found yet?
> 
> make INSTALL_PATH=/tmp modules_install
> IIRC this is true for 2.4 as well.
> 
> 	Sam



:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | PGP Key ID: FC96D405
                               
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.
FYI:
 perl -e 'print $i=pack(c5,(41*2),sqrt(7056),(unpack(c,H)-2),oct(115),10);'

