Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270692AbTG0H7N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 03:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270693AbTG0H7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 03:59:13 -0400
Received: from dsl-200-55-80-165.prima.net.ar ([200.55.80.165]:21120 "EHLO
	runner.matiu.com.ar") by vger.kernel.org with ESMTP id S270692AbTG0H7L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 03:59:11 -0400
Subject: Re: [kernel 2.6.0-test1: Fails to load anymodules
From: Matias Alejo Garcia <linux@matiu.com.ar>
To: Manjunathan Padua Yellappan <manjunathan_py@yahoo.com>
Cc: Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030727072221.12288.qmail@web14207.mail.yahoo.com>
References: <20030727072221.12288.qmail@web14207.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Organization: 
Message-Id: <1059296739.1205.5.camel@runner>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 27 Jul 2003 05:05:39 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manjunathan,
	The new module-tools uses /etc/modprobe.conf instead of
/etc/modules.conf, so you need to upgrade your old configuration. There
is a script for that @ the module-init web.
	
	Also, I have installed 'module-init-tools version 0.9.11a'
for 2.6.0t1.(you can check the installed version with modprobe -V)

	Hope this helps,
matías

On Sun, 2003-07-27 at 03:22, Manjunathan Padua Yellappan wrote:
>  Hi Folks,
>    Thanks for all, for assisting me in solving the
>  kernel booting problem.
>  
>   Now I am encountering another problem, after
>  successful compilation/installation/booting of kernel
>  2.6.0-test1 , the modules are not loading at all ,
>  even after installing the latest version of
>  "module-init-tools-0.9.13-pre" .
>  
>  Below given the error message that is display during
>  booting time, when kernel checks for the hardware !
>  
>  "XT3 FS on hda9, internal journal
>  Adding 538136k swap on /dev/hda10.  Priority:-1
>  extents:1
>  kudzu: numerical sysctl 1 23 is obsolete.
>  warning: process `update' used the obsolete bdflush
>  system call
>  Fix your initscripts?
>  warning: process `update' used the obsolete bdflush
>  system call
>  Fix your initscripts?
>  kudzu: numerical sysctl 1 23 is obsolete.
>  module_upgrade: numerical sysctl 1 23 is obsolete.
>  module_upgrade: numerical sysctl 1 49 is obsolete.
>  module_upgrade: numerical sysctl 1 49 is obsolete.
>  kudzu: numerical sysctl 1 23 is obsolete.
>  updfstab: numerical sysctl 1 23 is obsolete.
>  updfstab: numerical sysctl 1 49 is obsolete.
>  updfstab: numerical sysctl 1 49 is obsolete.
>  kudzu: numerical sysctl 1 23 is obsolete."
>  
>  Because of this, my sound card, D-link FM radio and
>  other periperal don't work.
>  
>  Further when I execut the new lsmod command. Module
>  list is displayed empty.
>  
>  I appreciate any asistance on this !
>  
>  Thanks,
>  Manjunathan PY
>  
> 
> __________________________________
> Do you Yahoo!?
> Yahoo! SiteBuilder - Free, easy-to-use web site design software
> http://sitebuilder.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
