Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267180AbTAFWZA>; Mon, 6 Jan 2003 17:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267183AbTAFWZA>; Mon, 6 Jan 2003 17:25:00 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:3496 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id <S267180AbTAFWZA>;
	Mon, 6 Jan 2003 17:25:00 -0500
Date: Mon, 6 Jan 2003 22:33:38 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dummy ethernet driver
In-Reply-To: <1041864865.17472.5.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0301062229330.29921-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mon, 2003-01-06 at 05:57, Dave Airlie wrote:
> > the patch is attached.. is there any reason why the dummy device doesn't
> > want to do this stuff? I'm just submitting the patch as a request for
> > comments on why this isn't done anyway in the dummy
>
> If you want to talk to local systems why don't you use the netlink
> interface/ethertap stuff ?

because I'm unconscionably lazy, and the VAX simulator code is already
written to use pcap and I'd rather not rewrite it, why fix something when
a quick hack will suffice :-)

my long term plan is too ethertap the simulator alright.. but moving along
the Linux/VAX project is primary, fixing simulator isn't :-)

I'm just wondering why dummy just do that bit more.. design decision? or
nobodys ever bothered?

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person


