Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267487AbSLLUNj>; Thu, 12 Dec 2002 15:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267484AbSLLUNj>; Thu, 12 Dec 2002 15:13:39 -0500
Received: from host136-27.pool217141.interbusiness.it ([217.141.27.136]:32772
	"EHLO mdvsrvsmtp01.north.h3g.it") by vger.kernel.org with ESMTP
	id <S267482AbSLLUNh> convert rfc822-to-8bit; Thu, 12 Dec 2002 15:13:37 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: R: Kernel bug handling TCP_RTO_MAX?
Date: Thu, 12 Dec 2002 21:18:21 +0100
Message-ID: <047ACC5B9A00D741927A4A32E7D01B73D66178@RMEXC01.h3g.it>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel bug handling TCP_RTO_MAX?
thread-index: AcKiGRE9dmZ5swlEQLyfhQEWHuvzWAAAIXdg
From: "Andreani Stefano" <stefano.andreani.ap@h3g.it>
To: "David S. Miller" <davem@redhat.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>
X-OriginalArrivalTime: 12 Dec 2002 20:18:22.0365 (UTC) FILETIME=[9E4FECD0:01C2A21B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Never say never ;-) 
I need to change it now as a temporary workaround for a problem in the UMTS core network of my company. But I think there could be thousands of situations where a fine tuning of this TCP parameter could be useful.

Any contributes on the problem?

Stefano.

-----Messaggio originale-----
Da: David S. Miller [mailto:davem@redhat.com]
Inviato: giovedì 12 dicembre 2002 20.59
A: Andreani Stefano
Cc: linux-kernel@vger.kernel.org; linux-net@vger.kernel.org
Oggetto: Re: Kernel bug handling TCP_RTO_MAX?


   From: "Andreani Stefano" <stefano.andreani.ap@h3g.it>
   Date: Thu, 12 Dec 2002 20:15:42 +0100

   Problem: I need to change the max value of the TCP retransmission
   timeout.

Why?  There should be zero reason to change this value.
