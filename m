Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318193AbSHDQ55>; Sun, 4 Aug 2002 12:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318196AbSHDQ54>; Sun, 4 Aug 2002 12:57:56 -0400
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:27076 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S318193AbSHDQ5z>; Sun, 4 Aug 2002 12:57:55 -0400
Message-ID: <3D4D5DCB.88F1484E@ntlworld.com>
Date: Sun, 04 Aug 2002 18:00:59 +0100
From: alien.ant@ntlworld.com
X-Mailer: Mozilla 4.7 [en-gb] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Alex Davis <alex14641@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 IDE Partition Check issue
References: <20020804054239.62923.qmail@web9203.mail.yahoo.com>
		<1028470037.14195.24.camel@irongate.swansea.linux.org.uk> 
		<3D4D4544.4045B5D3@ntlworld.com> <1028480553.14195.35.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:
> 
> On Sun, 2002-08-04 at 16:16, alien.ant@ntlworld.com wrote:
> >
> > Alan - I'm wondering if this issue is related to Maxtor drives? All the
> > reports I have seen of this problem have featured drives from this
> > manufacturer.
> 
> The ALi hang may well be sort of this. If its what Andre thinks then its
> lack of support for LBA48 on ALi interface hardware (or at least for the
> documentation we currently have on how to program it). If so -ac2 should
> sort that one out

In my case I'm using a Highpoint and not an ALi controller. People also
seem to experience the same problem with Promise, ALi and Highpoint
controllers on the 2.4.19-pre kernels so it looks unlikely to be a
controller spei
