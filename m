Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129485AbRBRUde>; Sun, 18 Feb 2001 15:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129803AbRBRUd2>; Sun, 18 Feb 2001 15:33:28 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:9481 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129485AbRBRUdT>;
	Sun, 18 Feb 2001 15:33:19 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200102182032.XAA28257@ms2.inr.ac.ru>
Subject: Re: MTU and 2.4.x kernel
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sun, 18 Feb 2001 23:32:57 +0300 (MSK)
Cc: davem@redhat.com (Dave Miller), linux-kernel@vger.kernel.org
In-Reply-To: <E14TTRF-0000Ul-00@the-village.bc.nu> from "Alan Cox" at Feb 15, 1 06:47:31 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Please cite an exact RFC reference.

Imagine, I found this reference yet. This is rfc1191, of course. 8)

   in the MSS option.  The MSS option should be 40 octets less than the
   size of the largest datagram the host is able to reassemble (MMS_R,
   as defined in [1]); in many cases, this will be the architectural
   limit of 65495 (65535 - 40) octets.

Alexey


PS: But:

   					A host MAY send an MSS value
   derived from the MTU of its connected network (the maximum MTU over
   its connected networks, for a multi-homed host); this should not
   cause problems for PMTU Discovery, and may dissuade a broken peer
   from sending enormous datagrams.

          Note: At the moment, we see no reason to send an MSS greater
          than the maximum MTU of the connected networks, and we
          recommend that hosts do not use 65495.  It is quite possible
          that some IP implementations have sign-bit bugs that would be
          tickled by unnecessary use of such a large MSS.

