Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275552AbRIZTuC>; Wed, 26 Sep 2001 15:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275531AbRIZTtw>; Wed, 26 Sep 2001 15:49:52 -0400
Received: from dfw-smtpout4.email.verio.net ([129.250.36.44]:20112 "EHLO
	dfw-smtpout4.email.verio.net") by vger.kernel.org with ESMTP
	id <S275552AbRIZTtk>; Wed, 26 Sep 2001 15:49:40 -0400
Message-ID: <3BB23168.FA0256CD@bigfoot.com>
Date: Wed, 26 Sep 2001 12:50:00 -0700
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.20p10i i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jlmales@softhome.net
CC: Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel 2.2.20-pre10 Initial Impressions
In-Reply-To: <3BB116BF.19313.7E42D8@localhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"John L. Males" wrote:
> ...
> Ok, you make a good point in your suggestion re:
> 
> You will probably see dns requests going out. You should check to
> make sure that you are not blocking incomming udp ports (1024-5000
> for bind, not sure about resolver...) as that would lengthen the
> response time considerably if only a few are open, and completely
> stop you if all are blocked.
> ...

strace will instantly validate or eliminate DNS lookup delays as an
issue wo having to sort through tcpdump output.  In my case nscd was a
lifesaver and saved me from running local bind server.

rgds,
tim.
--
