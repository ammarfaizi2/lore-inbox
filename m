Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281020AbRK3UBM>; Fri, 30 Nov 2001 15:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281017AbRK3UAx>; Fri, 30 Nov 2001 15:00:53 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16910 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281005AbRK3UAr>; Fri, 30 Nov 2001 15:00:47 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Slow start -- Linux vs. NT -- it's time to acknowledge the
	problem!
Date: 30 Nov 2001 12:00:14 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9u8oge$tbq$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.40.0111301002110.3351-100000@twu.net> <1007137256.1244.0.camel@aurora>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1007137256.1244.0.camel@aurora>
By author:    "Trever L. Adams" <vichu@digitalme.com>
In newsgroup: linux.dev.kernel
>
> On Fri, 2001-11-30 at 11:02, Jessica Blank wrote:
> > Sooo... having the Windows-type person remove NetBEUI and Windows
> > filesharing (SMB) would fix this if this is indeed the cause of problems?
> > 
> 
> Partially.  SMB can be an ok netizen given that you disable NetBEUI and
> possibly IPX.  It won't be the best netizen, but it won't be so insanely
> broken.
> 

Indeed.  Note that even Microsoft have been recommending running SMB
over TCP/IP and disabling other protocols for many years now; starting
in Win98 this is the default configuration.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
