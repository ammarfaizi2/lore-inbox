Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287582AbRLaRel>; Mon, 31 Dec 2001 12:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287583AbRLaReb>; Mon, 31 Dec 2001 12:34:31 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:38108 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S287582AbRLaReW>; Mon, 31 Dec 2001 12:34:22 -0500
Date: Mon, 31 Dec 2001 11:34:08 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200112311734.LAA43032@tomcat.admin.navo.hpc.mil>
To: jgarzik@mandrakesoft.com,
        Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Subject: Re: how to map network cards ?
CC: girish@bombay.retortsoft.com, linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> Jesse Pollard wrote:
> > The only way to determine
> > the ACTUAL eth0 is via mac number and trial and error.
> 
> not correct, as noted in other e-mail.
> 
> > I configure ONE interface (all others are down), then plug in to a working
> > network.
> > 
> > If I can ping the other machine then I know which network a given
> > interface is on - label it.
> > 
> > Now down that interface, and initialize another one. Repeat until all
> > interfaces are identified.
> 
> also note that one can rename interfaces, or in the future they might
> appear out-of-order.  To only way to be obsolutely certain where a
> network device is on the PCI bus is ETHTOOL_GDRVINFO.
> 
> 	Jeff

Does ETHTOOL_GDRVINFO work on ISA devices too? Last I knew it didn't. And
I do run a system with both PCI and ISA network cards.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
