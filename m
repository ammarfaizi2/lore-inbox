Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264610AbSIQUFP>; Tue, 17 Sep 2002 16:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264612AbSIQUFO>; Tue, 17 Sep 2002 16:05:14 -0400
Received: from ns1.cypress.com ([157.95.67.4]:35218 "EHLO ns1.cypress.com")
	by vger.kernel.org with ESMTP id <S264610AbSIQUFN>;
	Tue, 17 Sep 2002 16:05:13 -0400
Message-ID: <3D878BFD.4040308@cypress.com>
Date: Tue, 17 Sep 2002 15:09:33 -0500
From: Thomas Dodd <ted@cypress.com>
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net,
       gen-lists@blueyonder.co.uk
Subject: Re: Problems accessing USB Mass Storage
References: <1032261937.1170.13.camel@stimpy.angelnet.internal> <20020917151816.GB2144@kroah.com> <3D876861.9000601@cypress.com> <20020917174631.GD2569@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Greg KH wrote:
> On Tue, Sep 17, 2002 at 12:37:37PM -0500, Thomas Dodd wrote:
> 
>>I get the feeling it's not a true mass storage device.
> 
> 
> Sounds like it.

> Windows drivers don't help me much, maybe one of the other usb
> developers could help.

Looking at the driver files, this is interesting:

	dmusic.sys
	gm16.dls
	kmixer.sys
	ks.sys
	ksclockf.ax
	ksdata.ax
	ksinterf.ax
	ksproxy.ax
	kstvtune.ax
	ksuser.dll
	ksvpintf.ax
	kswdmcap.ax
	ksxbar.ax
	msh263.drv
	mskssrv.sys
	mspclock.sys
	portcls.sys
	redbook.sys

redbook? isn't that CD related?


	sbemul.sys
	stream.sys
	swmidi.sys
	sysaudio.sys
	usbaudio.sys
	vfwwdm.drv
	vfwwdm32.dll
	wdmaud.drv
	wdmaud.sys

I also see a lot of audio related files like usbaudio, sbemul,gm16,
swmidi, and dmusic.

Mark, are there any other interfaces in the output form lsusb?
I didn't see them in dmesg from the connection. But the windows drivers
make me think there should be a usb-audio interface.


	-Thomas

