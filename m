Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267686AbTBUU3N>; Fri, 21 Feb 2003 15:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267687AbTBUU3N>; Fri, 21 Feb 2003 15:29:13 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:5896 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S267686AbTBUU3M>; Fri, 21 Feb 2003 15:29:12 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302212040.h1LKejY3001679@81-2-122-30.bradfords.org.uk>
Subject: Re: RFC3168, section 6.1.1.1 - ECN and retransmit of SYN
To: Valdis.Kletnieks@vt.edu
Date: Fri, 21 Feb 2003 20:40:45 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200302212013.h1LKD6Cu014437@turing-police.cc.vt.edu> from "Valdis.Kletnieks@vt.edu" at Feb 21, 2003 03:13:06 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> RFC3168 section 6.1.1.1 says this:
> 
>    A host that receives no reply to an ECN-setup SYN within the normal
>    SYN retransmission timeout interval MAY resend the SYN and any
>    subsequent SYN retransmissions with CWR and ECE cleared.  To overcome
>    normal packet loss that results in the original SYN being lost, the
>    originating host may retransmit one or more ECN-setup SYN packets
>    before giving up and retransmitting the SYN with the CWR and ECE bits
>    cleared.
> 
> Supporting this would make using ECN a lot less painful - currently, if
> I want to use ECN by default, I get to turn it off anytime I find an
> ECN-hostile site that I'd like to communicate with.

Linux shouldn't encourage the use of equipment that violates RFCs, in
this case, RFC 739.

The correct way to deal with it, is to contact the maintainers of the
site, and ask them to fix the non conforming equipment.

If the problem is caused upstream, by equipment out of the
site's maintainers' control, it is their responsibility to contact the
relevant maintainers, or change their upstream provider.

John.
