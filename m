Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280646AbRKYBrv>; Sat, 24 Nov 2001 20:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280641AbRKYBrm>; Sat, 24 Nov 2001 20:47:42 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46092 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280646AbRKYBra>; Sat, 24 Nov 2001 20:47:30 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Network hardware: "Network Media Detection"
Date: 24 Nov 2001 17:47:04 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9tpiio$n4u$1@cesium.transmeta.com>
In-Reply-To: <E167ja2-0004fF-00@carbon.btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E167ja2-0004fF-00@carbon.btinternet.com>
By author:    Jeff Snyder <je4d@pobox.com>
In newsgroup: linux.dev.kernel
>
> Hi
> I was wondering if there was any way in linux to use what redmond calls 
> "Network Media Detection"?
> 
> That is, it detects the presence of a (10BaseT) cable in the back of the 
> card.. and then does appropriate stuff (ifup/down, dhcpcd) when the event 
> happens.
> I remember  having this in W*nME, so can linux use it?
> if so can someone please give me some pointers to appropriate sites/howtos on 
> how to use it?
> 

This is basically taking the interface down when the link disappears
(and vice versa.)  Rather useful for portable systems.  Don't think
anyone has implemented it, but it should be easy enough to do.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
