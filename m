Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262485AbTD3Wxd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 18:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbTD3Wxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 18:53:33 -0400
Received: from jstevenson.plus.com ([212.159.71.212]:25281 "EHLO
	alpha.stev.org") by vger.kernel.org with ESMTP id S262485AbTD3Wx2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 18:53:28 -0400
Subject: Re: software reset
From: James Stevenson <james@stev.org>
To: joe briggs <jbriggs@briggsmedia.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200304291037.13598.jbriggs@briggsmedia.com>
References: <200304291037.13598.jbriggs@briggsmedia.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 01 May 2003 00:12:37 +0100
Message-Id: <1051744358.1529.7.camel@god.stev.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

1 way to get a garentee reboot is to use a 2nd computer a parrell port
and a resistor + relay and get the relay to short the reset pins
on the MB of the machine you wish to reboot.

You could set this up to reboot up 2 8 machine usign cheap hardware
like a 486 or something.

On Tue, 2003-04-29 at 15:37, joe briggs wrote:
> Can anyone tell me how to absolutely force a reset on a i386?  Specifically, 
> is there a system call that will call the assembly instruction to assert the 
> RESET bus line? I try to use the "reboot(LINUX_REBOOT_CMD_RESTART,0,0,NULL)" 
> call, but it will not always work.  Occassionally, I experience a "missed 
> interrupt" on a Promise IDE controller, and while I can telnet into the 
> system, I can't reset it.  Any help greatly appreciated!  Since these systems 
> are 1000's of miles away, the need to remotely reset it paramont.
> 
> 
> -- 
> Joe Briggs
> Briggs Media Systems
> 105 Burnsen Ave.
> Manchester NH 01304 USA
> TEL/FAX 603-232-3115 MOBILE 603-493-2386
> www.briggsmedia.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



