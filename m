Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263894AbTG1L42 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 07:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265440AbTG1L42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 07:56:28 -0400
Received: from web14208.mail.yahoo.com ([216.136.173.72]:43021 "HELO
	web14208.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263894AbTG1L4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 07:56:25 -0400
Message-ID: <20030728121140.8237.qmail@web14208.mail.yahoo.com>
Date: Mon, 28 Jul 2003 05:11:40 -0700 (PDT)
From: Manjunathan Padua Yellappan <manjunathan_py@yahoo.com>
Subject: Re: [kernel 2.6.0-test1: Fails to load anymodules
To: Matias Alejo Garcia <linux@matiu.com.ar>
Cc: Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1059296739.1205.5.camel@runner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matias,
 I compiled and installed module-init-tools version
0.9.13, but still it gives the same QM_MODULES not
found error during hardware checking at the start up
of the OS and load no modules!

I examined the /etc/modprobe.conf, it seems to be
fine. 

Waiting for more help !

Cheers,
Manjunathan PY

--- Matias Alejo Garcia <linux@matiu.com.ar> wrote:
> Hi Manjunathan,
> 	The new module-tools uses /etc/modprobe.conf
> instead of
> /etc/modules.conf, so you need to upgrade your old
> configuration. There
> is a script for that @ the module-init web.
> 	
> 	Also, I have installed 'module-init-tools version
> 0.9.11a'
> for 2.6.0t1.(you can check the installed version
> with modprobe -V)
> 
> 	Hope this helps,
> matías
> 
> On Sun, 2003-07-27 at 03:22, Manjunathan Padua
> Yellappan wrote:
> >  Hi Folks,
> >    Thanks for all, for assisting me in solving the
> >  kernel booting problem.
> >  
> >   Now I am encountering another problem, after
> >  successful compilation/installation/booting of
> kernel
> >  2.6.0-test1 , the modules are not loading at all
> ,
> >  even after installing the latest version of
> >  "module-init-tools-0.9.13-pre" .
> >  
> >  Below given the error message that is display
> during
> >  booting time, when kernel checks for the hardware
> !
> >  
> >  "XT3 FS on hda9, internal journal
> >  Adding 538136k swap on /dev/hda10.  Priority:-1
> >  extents:1
> >  kudzu: numerical sysctl 1 23 is obsolete.
> >  warning: process `update' used the obsolete
> bdflush
> >  system call
> >  Fix your initscripts?
> >  warning: process `update' used the obsolete
> bdflush
> >  system call
> >  Fix your initscripts?
> >  kudzu: numerical sysctl 1 23 is obsolete.
> >  module_upgrade: numerical sysctl 1 23 is
> obsolete.
> >  module_upgrade: numerical sysctl 1 49 is
> obsolete.
> >  module_upgrade: numerical sysctl 1 49 is
> obsolete.
> >  kudzu: numerical sysctl 1 23 is obsolete.
> >  updfstab: numerical sysctl 1 23 is obsolete.
> >  updfstab: numerical sysctl 1 49 is obsolete.
> >  updfstab: numerical sysctl 1 49 is obsolete.
> >  kudzu: numerical sysctl 1 23 is obsolete."
> >  
> >  Because of this, my sound card, D-link FM radio
> and
> >  other periperal don't work.
> >  
> >  Further when I execut the new lsmod command.
> Module
> >  list is displayed empty.
> >  
> >  I appreciate any asistance on this !
> >  
> >  Thanks,
> >  Manjunathan PY
> >  
> > 
> > __________________________________
> > Do you Yahoo!?
> > Yahoo! SiteBuilder - Free, easy-to-use web site
> design software
> > http://sitebuilder.yahoo.com
> > -
> > To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/


__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
