Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267701AbTAaGIB>; Fri, 31 Jan 2003 01:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267709AbTAaGIB>; Fri, 31 Jan 2003 01:08:01 -0500
Received: from 12-240-9-4.client.attbi.com ([12.240.9.4]:56961 "EHLO
	pinkie.homelinux.net") by vger.kernel.org with ESMTP
	id <S267701AbTAaGIA>; Fri, 31 Jan 2003 01:08:00 -0500
Message-ID: <3E3A14D4.7090907@lbl.gov>
Date: Thu, 30 Jan 2003 22:16:52 -0800
From: Thomas Davis <tadavis@lbl.gov>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin K. Petersen" <mkp@mkp.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre4
References: <Pine.LNX.4.53L.0301290143350.27119@freak.distro.conectiva>	<3E384D41.9080605@lbl.gov>	<1043926998.28133.21.camel@irongate.swansea.linux.org.uk>	<3E395C30.6040903@lbl.gov>	<1043950661.31674.12.camel@irongate.swansea.linux.org.uk>	<3E396032.2000503@lbl.gov>	<1043951291.31674.17.camel@irongate.swansea.linux.org.uk>	<3E39669F.20302@lbl.gov>	<1043955332.31674.27.camel@irongate.swansea.linux.org.uk>	<3E39730D.3090009@lbl.gov> <yq1vg06qlhk.fsf@austin.mkp.net>	<3E39E9FC.5070307@lbl.gov> <yq1el6uq7tq.fsf@austin.mkp.net>	<3E39F7E6.20300@lbl.gov> <yq1wukmos82.fsf@austin.mkp.net>
In-Reply-To: <yq1wukmos82.fsf@austin.mkp.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hmm.. how about - DT9011 doesn't mean crap to any one..  DT0893 is printed in big clear letters on it.

this is what things like kmix (from kde) uses to indicate sound card.

so put both on it.

thomas

Martin K. Petersen wrote:
>>>>>>"Thomas" == Thomas Davis <tadavis@lbl.gov> writes:
> 
> 
>>>What does it say on the codec chip?  Is that the DT9011?
> 
> 
> Thomas> yup, in itty bitty print.
> 
> In that case I'd suggest the following:
> 
--- linux-2.4.21-pre2/drivers/sound/ac97_codec.c        Tue Dec 24 15:37:53 2002
+++ linux-2.4.20-ac1/drivers/sound/ac97_codec.c Fri Dec  6 00:07:04 2002
@@ -133,6 +133,7 @@
        {0x43525931, "Cirrus Logic CS4299 rev A", &crystal_digital_ops},
        {0x43525933, "Cirrus Logic CS4299 rev C", &crystal_digital_ops},
        {0x43525934, "Cirrus Logic CS4299 rev D", &crystal_digital_ops},
+       {0x44543031, "Diamond Technologies DT0893/DT9011", &null_ops},
        {0x45838308, "ESS Allegro ES1988",      &null_ops},
        {0x49434511, "ICE1232",                 &null_ops}, /* I hope --jk */
        {0x4e534331, "National Semiconductor LM4549", &null_ops},


