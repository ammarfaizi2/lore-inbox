Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266645AbTAaEV3>; Thu, 30 Jan 2003 23:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266660AbTAaEV3>; Thu, 30 Jan 2003 23:21:29 -0500
Received: from jaguar.mkp.net ([66.11.169.42]:19373 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id <S266645AbTAaEV2>;
	Thu, 30 Jan 2003 23:21:28 -0500
To: Thomas Davis <tadavis@lbl.gov>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre4
From: "Martin K. Petersen" <mkp@mkp.net>
Organization: mkp.net
References: <Pine.LNX.4.53L.0301290143350.27119@freak.distro.conectiva>
	<3E384D41.9080605@lbl.gov>
	<1043926998.28133.21.camel@irongate.swansea.linux.org.uk>
	<3E395C30.6040903@lbl.gov>
	<1043950661.31674.12.camel@irongate.swansea.linux.org.uk>
	<3E396032.2000503@lbl.gov>
	<1043951291.31674.17.camel@irongate.swansea.linux.org.uk>
	<3E39669F.20302@lbl.gov>
	<1043955332.31674.27.camel@irongate.swansea.linux.org.uk>
	<3E39730D.3090009@lbl.gov> <yq1vg06qlhk.fsf@austin.mkp.net>
	<3E39E9FC.5070307@lbl.gov> <yq1el6uq7tq.fsf@austin.mkp.net>
	<3E39F7E6.20300@lbl.gov>
Date: 30 Jan 2003 23:31:25 -0500
In-Reply-To: <3E39F7E6.20300@lbl.gov>
Message-ID: <yq1wukmos82.fsf@austin.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Thomas" == Thomas Davis <tadavis@lbl.gov> writes:

>> What does it say on the codec chip?  Is that the DT9011?

Thomas> yup, in itty bitty print.

In that case I'd suggest the following:

--- linux-2.4.21-pre2/drivers/sound/ac97_codec.c        Tue Dec 24 15:37:53 2002
+++ linux-2.4.20-ac1/drivers/sound/ac97_codec.c Fri Dec  6 00:07:04 2002
@@ -133,6 +133,7 @@
        {0x43525931, "Cirrus Logic CS4299 rev A", &crystal_digital_ops},
        {0x43525933, "Cirrus Logic CS4299 rev C", &crystal_digital_ops},
        {0x43525934, "Cirrus Logic CS4299 rev D", &crystal_digital_ops},
+       {0x44543031, "Diamond Technologies DT9011", &null_ops},
        {0x45838308, "ESS Allegro ES1988",      &null_ops},
        {0x49434511, "ICE1232",                 &null_ops}, /* I hope --jk */
        {0x4e534331, "National Semiconductor LM4549", &null_ops},
