Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133024AbRECTac>; Thu, 3 May 2001 15:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133040AbRECTaY>; Thu, 3 May 2001 15:30:24 -0400
Received: from mail2.megatrends.com ([155.229.80.11]:30477 "EHLO
	mail2.megatrends.com") by vger.kernel.org with ESMTP
	id <S133062AbRECTaM>; Thu, 3 May 2001 15:30:12 -0400
Message-ID: <1355693A51C0D211B55A00105ACCFE6402B9DECC@ATL_MS1>
From: Venkatesh Ramamurthy <Venkateshr@ami.com>
To: "'Jesse Pollard'" <pollard@tomcat.admin.navo.hpc.mil>,
        Venkatesh Ramamurthy <Venkateshr@ami.com>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
        Venkatesh Ramamurthy <Venkateshr@ami.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: [RFC] Direct Sockets Support??
Date: Thu, 3 May 2001 15:25:07 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	> Doesn't this bypass all of the network security controls? Granted
- it is
	> completely reasonable in a dedicated environment, but I would
think the
	> security loss would prevent it from being used for most usage.

	Direct Sockets makes sense only in clustering (server farms) to
reduce intra-farm communication. It is *not* supposed to be used for regular
internet. Direct Sockets over subnets is also tough to implement it across
different topology subnets. Fabrics like Infiniband provide security on
hardware, so there is no need to worry about it. The simple point  is that
hw supports TCP/IP, then why do we need a software TCP/IP over it?

