Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263686AbTE0OpM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 10:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263657AbTE0OpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 10:45:12 -0400
Received: from [62.159.241.4] ([62.159.241.4]:50191 "EHLO smtp.lidl.de")
	by vger.kernel.org with ESMTP id S263686AbTE0OpK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 10:45:10 -0400
Subject: Antwort: Re: Antwort: Re: Oops in Kernel 2.4.21-rc1
To: skraw@ithnet.com
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.10  March 22, 2002
Message-ID: <OFBC4DE14D.84808A7E-ONC1256D33.005135A5-C1256D33.00523E77@eu.lidl.net>
From: Werner.Beck@Lidl.de
Date: Tue, 27 May 2003 16:58:19 +0200
MIME-Version: 1.0
X-MIMETrack: Serialize by Router on LEUHQ0001MS6N/HUB/EU/LIDL(Release 5.0.10 |March 22, 2002) at
 27.05.2003 16:58:21,
	Itemize by SMTP Server on LEUHQ0001MS5N/LIDLEUEX(Release 5.0.10 |March 22, 2002) at
 27.05.2003 16:54:28,
	Serialize by Router on LEUHQ0001MS5N/LIDLEUEX(Release 5.0.10 |March 22, 2002) at
 27.05.2003 16:54:31,
	Serialize complete at 27.05.2003 16:54:31
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


we just did an update from 2.4.10-SuSE because of some problems with the
hardware (module for NIC and HDD). In this constellation we also had a
kernel oops with the ISDN ("killing interrupt handler") which unfortunately
didn't give us any hints in the logs.
The systems are a field test and running an application that's why it is a
problem to access them. I think a cause has an effect. The ISDN was not
active at that time but probably a job of the SuSE distri, but I can't
imagine that this causes kernel problems.
 I will run a test in our lab and hope to get the error, then I can do some
changes with the system.
Thanks for your hints...



|---------+---------------------------->
|         |           Stephan von      |
|         |           Krawczynski      |
|         |           <skraw@ithnet.com|
|         |           >                |
|         |                            |
|         |           27.05.2003 16:07 |
|         |                            |
|---------+---------------------------->
  >------------------------------------------------------------------------------------------------------------------------------|
  |                                                                                                                              |
  |       An:       Werner.Beck@Lidl.de                                                                                          |
  |       Kopie:    linux-kernel@vger.kernel.org                                                                                 |
  |       Thema:    Re: Antwort: Re: Oops in Kernel 2.4.21-rc1                                                                   |
  >------------------------------------------------------------------------------------------------------------------------------|




On Tue, 27 May 2003 15:54:40 +0200
Werner.Beck@Lidl.de wrote:

> unfortunately that is not possible at the moment...
>

>> Exchange the USB/ISDN part with a pci card and re-try with kernel -rc4.
>
>> Tell us if that works.
>
>> Regards,
>> Stephan

Well, what exactly do you expect to hear? There are about a million and one
possibilities about your problem. Most of them are hardware-related. Hoping
that you have already made sure that you have no defective RAM, controller,
mainboard or the like (unlikely since you mention two hosts) I would
eliminate
additional risk factors like USB (always gives fun) and use the latest
kernel.

Regards,
Stephan





