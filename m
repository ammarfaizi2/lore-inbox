Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275265AbRKAMQW>; Thu, 1 Nov 2001 07:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277282AbRKAMQM>; Thu, 1 Nov 2001 07:16:12 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:18829 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S275265AbRKAMPz>; Thu, 1 Nov 2001 07:15:55 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Hasch@t-online.de (Juergen Hasch)
To: linux-kernel@vger.kernel.org,
        Thomas =?iso-8859-1?q?Lang=E5s?= <tlan@stud.ntnu.no>,
        Andrey Savochkin <saw@saw.sw.com.sg>
Subject: Re: Intel EEPro 100 with kernel drivers
Date: Thu, 1 Nov 2001 13:15:33 +0100
X-Mailer: KMail [version 1.3]
Cc: J Sloan <jjs@pobox.com>
In-Reply-To: <20011029021339.B23985@stud.ntnu.no> <20011101141111.A27180@castle.nmd.msu.ru> <20011101130044.D3409@stud.ntnu.no>
In-Reply-To: <20011101130044.D3409@stud.ntnu.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <15zGl5-0pPJsuC@fwd03.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 1. November 2001 13:00 schrieb Thomas Langås:
> Andrey Savochkin:
> > It should be Rx_TCO_Packets, not Tx.
> > The problem described in Intel's advisory is related to incorrect
> > processing of receiving packets.
>
> But if it's this bug that's triggered with NFS-traffic, then the counter
> should be increasing with every timeout, right? Not just one time. I get a
> lot of timeout and the counter is still just 1.
>
> I'm going out to buy me another NIC and try tests a bit systematically, and
> report back with the results afterwards.

The Rx_TCO_Packets counter should increase at each timeout you get,
so this looks like another problem.

I have got two servers with two different EEPRO100 network cards. 
One works better with the eepro100 driver, the other one seems to favour the 
e100 driver :-)
Both cards are working flawlessly now, however I was close to buying new NICs 
because of the problems like command timeouts, no resources messages and NFS 
timeouts.

...Juergen
