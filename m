Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUKPSuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUKPSuh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 13:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbUKPSuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 13:50:37 -0500
Received: from smtp.dei.uc.pt ([193.137.203.228]:62340 "EHLO smtp.dei.uc.pt")
	by vger.kernel.org with ESMTP id S262085AbUKPSuZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 13:50:25 -0500
Date: Tue, 16 Nov 2004 18:43:52 +0000 (WET)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.27-3
In-Reply-To: <20041116134027.GA13360@elte.hu>
Message-ID: <Pine.LNX.4.61.0411161843120.27976@student.dei.uc.pt>
References: <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu>
 <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu>
 <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu>
 <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu>
 <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu>
 <20041116134027.GA13360@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-UC-FCTUC-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-FCTUC-DEI-MailScanner: Found to be clean
X-MailScanner-From: marado@student.dei.uc.pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, 16 Nov 2004, Ingo Molnar wrote:

> to create a -V0.7.27-3 tree from scratch, the patching order is:
>
>  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.9.tar.bz2
>  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.10-rc2.bz2
>  http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm1/2.6.10-rc2-mm1.bz2
>  http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.10-rc2-mm1-V0.7.27-3
>

root@Atlantis:/usr/src# wget http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.10-rc2-mm1-V0.7.27-3
- --18:43:08--  http://redhat.com/%7Emingo/realtime-preempt/realtime-preempt-2.6.10-rc2-mm1-V0.7.27-3
            => `realtime-preempt-2.6.10-rc2-mm1-V0.7.27-3'
Resolving redhat.com... 209.132.177.50
Connecting to redhat.com[209.132.177.50]:80... connected.
HTTP request sent, awaiting response... 302 Found
Location: http://www.redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.10-rc2-mm1-V0.7.27-3 [following]
- --18:43:11--  http://www.redhat.com/%7Emingo/realtime-preempt/realtime-preempt-2.6.10-rc2-mm1-V0.7.27-3
            => `realtime-preempt-2.6.10-rc2-mm1-V0.7.27-3'
Resolving www.redhat.com... 209.132.177.50
Connecting to www.redhat.com[209.132.177.50]:80... connected.
HTTP request sent, awaiting response... 301 Moved Permanently
Location: http://people.redhat.com/mingo/realtime-preempt/realtime-preempt-2.6.10-rc2-mm1-V0.7.27-3 [following]
- --18:43:12--  http://people.redhat.com/mingo/realtime-preempt/realtime-preempt-2.6.10-rc2-mm1-V0.7.27-3
            => `realtime-preempt-2.6.10-rc2-mm1-V0.7.27-3'
Resolving people.redhat.com... 66.187.233.237
Connecting to people.redhat.com[66.187.233.237]:80... connected.
HTTP request sent, awaiting response... 404 Not Found
18:43:12 ERROR 404: Not Found.


Mind Booster Noori

- -- 
/* *************************************************************** */
    Marcos Daniel Marado Torres	     AKA	Mind Booster Noori
    http://student.dei.uc.pt/~marado   -	  marado@student.dei.uc.pt
    () Join the ASCII ribbon campaign against html email, Microsoft
    /\ attachments and Software patents.   They endanger the World.
    Sign a petition against patents:  http://petition.eurolinux.org
/* *************************************************************** */
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Made with pgp4pine 1.76

iD8DBQFBmkpqmNlq8m+oD34RAv3VAJ0Xk4PVQuKmxbWGS9BKCyTj/b3pUACg7H5W
hvMBsDXBU/3xSOJOI4jU7fA=
=AyKN
-----END PGP SIGNATURE-----

