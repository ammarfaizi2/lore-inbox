Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275628AbTHOBOG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 21:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275629AbTHOBOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 21:14:06 -0400
Received: from www.13thfloor.at ([212.16.59.250]:40141 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S275628AbTHOBOC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 21:14:02 -0400
Date: Fri, 15 Aug 2003 03:14:13 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Daniel Pezoa <dpforos@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TOPDIR kernel variable
Message-ID: <20030815011413.GC24130@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Daniel Pezoa <dpforos@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20030814231959.22781.qmail@web11204.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20030814231959.22781.qmail@web11204.mail.yahoo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 04:19:59PM -0700, Daniel Pezoa wrote:
> Hello Kernel Community !!  :-)
> 
> I'am compiling lirc software, the kernel source is
> needed to make them, but when i attemt to make them it
> fail because the environment variable TOPDIR is not
> set, looking for the origin of the problem, the script
> that fail is "pathdown.sh", one tiny script of the
> kernel, it fails when is trying to assign
> TP=${TOPDIR:). Reading more i found in the Kernel
> Makefile the line 
> 
> TOPDIR := $(shell /bin/pwd)
> 
> that command should solve my problem but if i launch
> them in the console, it give me the following errors
> in the screen ouput:
> 
> bash: shell: command not found
> bash: TOPDIR:=: command not found

probably your make is too old ...

http://cip.physik.uni-wuerzburg.de/virtualmanuals/root-doku/make/make_78.html

> What is the intention of the environment variable
> TOPDIR and how can i give them a valid value?

$(shell /bin/pwd) would evaluate the current/working directory

HTH,
Herbert

> Thanks for your help and Good luck!!  :-)
> 
> Daniel Pezoa
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
