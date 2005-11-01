Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932579AbVKAH4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579AbVKAH4E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 02:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbVKAH4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 02:56:04 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:21414 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932579AbVKAH4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 02:56:02 -0500
Subject: Re: 2.6.14-rt1 - xruns in a certain circumstance
From: Lee Revell <rlrevell@joe-job.com>
To: Nuno Silva <nuno.silva@vgertech.com>
Cc: Mark Knecht <markknecht@gmail.com>, "K.R. Foley" <kr@cybsft.com>,
       lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <4366C95B.1040400@vgertech.com>
References: <5bdc1c8b0510301828p29ea517ew467a5f6503435314@mail.gmail.com>
	 <50256.192.249.47.11.1130771450.squirrel@webmail2.pair.com>
	 <5bdc1c8b0510310726t105f8f8emd1d044f760a8a1eb@mail.gmail.com>
	 <1130776760.32101.40.camel@mindpipe>
	 <5bdc1c8b0510311522r530eefbfmf15b860ac8352824@mail.gmail.com>
	 <4366C95B.1040400@vgertech.com>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 02:54:13 -0500
Message-Id: <1130831654.32101.115.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-01 at 01:48 +0000, Nuno Silva wrote:
> Mark Knecht wrote:
> 
> [..]
> 
> > I took a quick look. If you get a chance where does the NoAccel option
> > go? Inside of the section for the radeon driver? I'm sure I can find
> > this online but won't have much of an opportunity for the next few
> > hours.
> 

Yes, in the "Device" section.

Try "man radeon" for more info, but it's something like:

      Section "Device"
         Identifier "devname"
         Driver "radeon"
         ...
	 Option "NoAccel"
	 ...

etc

Lee

