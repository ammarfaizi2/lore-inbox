Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292840AbSB0R0a>; Wed, 27 Feb 2002 12:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292826AbSB0R0Z>; Wed, 27 Feb 2002 12:26:25 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:63169 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S292840AbSB0RZ6>; Wed, 27 Feb 2002 12:25:58 -0500
From: "Nivedita Singhvi" <nivedita@us.ibm.com>
Importance: Normal
Sensitivity: 
Subject: Re: What is TCPRenoRecoveryFail ?
To: "David S. Miller" <davem@redhat.com>
Cc: bjorn.wesen@axis.com, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF7B1C71CE.E5A91A44-ON88256B6D.005E8A53@boulder.ibm.com>
Date: Wed, 27 Feb 2002 09:25:50 -0800
X-MIMETrack: Serialize by Router on D03NM035/03/M/IBM(Release 5.0.9 |November 16, 2001) at
 02/27/2002 10:25:52 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




> There are no options to negotiate DSACK,

Didnt mean option negotiation, the SACK permitted
works fine

> SACK implies DSACK will cause no harm.  An
> pre-DSACK implementation of SACK should
> effectively treat the DSACKs as nops, ie.
> they are harmless.

You would hope ;), but there is some bug in some Windoze I suspect
that gets confused by a duplicate SACK in some situation. I havent
been able to reproduce this on my hw, but have seen a strange trace
a while ago that was pretty similar.

thanks,
Nivedita


