Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbTDQPUW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 11:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbTDQPUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 11:20:22 -0400
Received: from realityfailure.org ([209.150.103.212]:46227 "EHLO
	bushido.realityfailure.org") by vger.kernel.org with ESMTP
	id S261595AbTDQPUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 11:20:21 -0400
Date: Thu, 17 Apr 2003 11:31:53 -0400 (EDT)
From: John Jasen <jjasen@realityfailure.org>
X-X-Sender: jjasen@bushido
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: root@chaos.analogic.com, joe briggs <jbriggs@briggsmedia.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Help with virus/hackers
In-Reply-To: <1050588754.31390.72.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0304171125130.13853-100000@bushido>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If you really want to examine the remains of a compromise, boot from a 
CD-based distro or something like that, and mount the partitions 
read-only.

If you don't want to, or have no idea what you're looking at, as Alan 
said, recover and verify user data, then reformat and reinstall.


On 17 Apr 2003, Alan Cox wrote:

> > (7)  Check /bin/login for a new file-date.
> > (8)  Check /usr/sbin/sendmail for a new file-date.
> >      Check /usr/sbin/inetd      ""
> >      Check /usr/sbin/xinetd     ""
> >      Check /usr/sbin/syslogd    ""
> >      Check /usr/sbin/klogd      ""
> >      Check /usr/sbin/in.*       ""
> 
> Rootkits know about avoiding this

Oh, yes. If you were running tripwire, and being good about keeping the 
database somewhere on read-only media, you might be able to detect file 
modifications. Place emphasis on might. 

> Never do this. You don't know what else has changed on the system. You
> should always (barring odd exceptions) do a full reinstall. Also clean
> user executable files if neccessary (roots .login is often archived and
> people rerun exploits from it...)

I'm trying to think up one of those odd situations ...

-- 
-- John E. Jasen (jjasen@realityfailure.org)
-- User Error #2361: Please insert coffee and try again.


