Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272304AbRIEUXJ>; Wed, 5 Sep 2001 16:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272305AbRIEUW7>; Wed, 5 Sep 2001 16:22:59 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:65036 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S272304AbRIEUWo>; Wed, 5 Sep 2001 16:22:44 -0400
Message-Id: <200109052023.f85KN1Y67662@aslan.scsiguy.com>
To: joe.mathewson@btinternet.com
cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx errors 
In-Reply-To: Your message of "Wed, 05 Sep 2001 07:21:10 BST."
             <200109050621.f856LAK00824@ambassador.mathewson.int> 
Date: Wed, 05 Sep 2001 14:23:01 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I've just woken up this morning to find my internet gateway machine only
>responding to pings, and on giving it a keyboard & monitor, a load of
>
>scsi0:0:1:0: Attempting to queue an ABORT message
>scsi0:0:1:0: Cmd aborted from QINFIFO
>aic7xxx_abort returns 8194
>
>errors.

I would have to see the messages with "aic7xxx=verbose"" in order
to better diagnose the problem.  A full dmesg that includes driver
initialization and SCSI device detection would be useful too.
You might also want to upgrade your driver to something newer:

	http://people.FreeBSD.org/~gibbs/linux/

--
Justin
