Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261851AbREVPMO>; Tue, 22 May 2001 11:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261856AbREVPME>; Tue, 22 May 2001 11:12:04 -0400
Received: from www.microgate.com ([216.30.46.105]:22542 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP
	id <S261851AbREVPLy>; Tue, 22 May 2001 11:11:54 -0400
Message-ID: <00bf01c0e2d9$de15b8c0$0c00a8c0@diemos>
From: "Paul Fulghum" <paulkf@microgate.com>
To: <rjd@xyzzy.clara.co.uk>, <paulus@samba.org>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <200105221334.f4MDYsc22597@xyzzy.clara.co.uk>
Subject: Re: SyncPPP IPCP/LCP loop problem and patch
Date: Tue, 22 May 2001 10:11:31 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Seems to me that when you get the conf-request in opened state, you
> > should send your conf-request before sending the conf-ack to the
> > peer's conf-request.  I think this would short-circuit the loop (I
> > could be wrong though, it's getting late).
> 
> Thanks but I've already tried that. You get a slightly different pattern
> to the loop but it still loops.

What does the loop look like when the cfg-req is sent 1st?

Paul Fulghum paulkf@microgate.com
Microgate Corporation www.microgate.com


