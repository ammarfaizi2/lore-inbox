Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262967AbUB0TGb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 14:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbUB0TGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 14:06:31 -0500
Received: from cpc1-cwma1-5-0-cust4.swan.cable.ntl.com ([80.5.120.4]:9899 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262967AbUB0TFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 14:05:40 -0500
Subject: Re: Errors on 2th ide channel of promise ultra100 tx2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: John Bradford <john@grabjohn.com>, Erik van Engelen <Info@vanE.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
In-Reply-To: <Pine.LNX.4.58L.0402271629430.19209@logos.cnet>
References: <403F2178.70806@vanE.nl>
	 <Pine.LNX.4.58L.0402271420250.18958@logos.cnet>
	 <200402271820.i1RIKVLb000744@81-2-122-30.bradfords.org.uk>
	 <Pine.LNX.4.58L.0402271629430.19209@logos.cnet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1077908499.29713.19.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 27 Feb 2004 19:01:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-02-27 at 19:30, Marcelo Tosatti wrote:
> > > Haven't got a clue about these "status=0x51" and "error=0x04". Anyone?
> >
> > Basically, the errors mean what they say - the drive is in an error
> > state, (received an unrecognised command), but is ready for further
> > operation.
> 
> Received an unrecognised command from the kernel? What can cause that?

Our early setup/probing code in 2.4.x at least may send stuff that very
very old disks don't understand. Its arguably a bug in the ident parsing
but it shouldnt ever be harmful

