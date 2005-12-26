Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbVLZMnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbVLZMnw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 07:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbVLZMnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 07:43:52 -0500
Received: from aeimail.aei.ca ([206.123.6.84]:10750 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S1750708AbVLZMnw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 07:43:52 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.15-rc6 - Success with ICH5/SATA + S.M.A.R.T.
Date: Mon, 26 Dec 2005 07:43:19 -0500
User-Agent: KMail/1.8.3
Cc: gcoady@gmail.com, Mark Lord <lkml@rtr.ca>,
       Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0512241830010.2700@p34> <sfftq1lhi7dvugooro7mjthksiqc6j8mg0@4ax.com> <43AEC119.8080109@pobox.com>
In-Reply-To: <43AEC119.8080109@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512260743.20931.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 25 December 2005 10:56, Jeff Garzik wrote:
> Grant Coady wrote:
> > On Sun, 25 Dec 2005 09:46:35 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> > 
> > 
> >>Ed Tomlinson wrote:
> >>
> >>>On Saturday 24 December 2005 18:43, Mark Lord wrote:
> >>>
> >>>
> >>>>>smartmontools is going to have to be updated
> >>>>
> >>>>What for?
> >>>>
> >>>>Use "smartctl -d ata /dev/sda"
> >>>
> >>>
> >>>Its not perfect:
> >>>
> >>>grover:/poola/home/ed# smartctl -d ata /dev/sda
> >>>smartctl version 5.34 [x86_64-unknown-linux-gnu] Copyright (C) 2002-5 Bruce Allen
> >>>Home page is http://smartmontools.sourceforge.net/
> >>>
> >>>smartctl has problems but hddtemp works
> >>
> >>What are the problems?  Your output gives us no clue...
> > 
> > 
> > That _is_ the clue, no output ;)  
> 
> Perhaps if the poster provided a useful command line to smartctl, it 
> would do useful work.
> 
> If you don't provide a command to smartctl, it won't do much of anything:
> 
> > [jgarzik@sata ~]$ sudo smartctl  /dev/hda1
> > smartctl version 5.33 [i386-redhat-linux-gnu] Copyright (C) 2002-4 Bruce Allen
> > Home page is http://smartmontools.sourceforge.net/
> 
> > [jgarzik@sata ~]$ sudo smartctl -d ata /dev/sda1
> > smartctl version 5.33 [i386-redhat-linux-gnu] Copyright (C) 2002-4 Bruce Allen
> > Home page is http://smartmontools.sourceforge.net/

Jeff,

You are quite right.  I rather blindly followed the example from Grant which just specified
the device type.  Adding a -a gets lots of info.

Thanks,
Ed Tomlinson


