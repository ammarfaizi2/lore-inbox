Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316763AbSE0VWq>; Mon, 27 May 2002 17:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316764AbSE0VWp>; Mon, 27 May 2002 17:22:45 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19205 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316763AbSE0VWo>; Mon, 27 May 2002 17:22:44 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Memory management in Kernel 2.4.x
Date: 27 May 2002 14:22:22 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <acu82e$7qn$1@cesium.transmeta.com>
In-Reply-To: <fa.iklie8v.5k2hbj@ifi.uio.no> <actahk$6bp$1@ID-44327.news.dfncis.de> <3CF23893.207@loewe-komp.de> <1022513156.1126.289.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1022513156.1126.289.camel@irongate.swansea.linux.org.uk>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
> 
> On a -ac kernel with mode 2 or 3 set for overcommit you have to run out
> of kernel resources to hang the box. It won't go OOM because it can't.
> That wouldn't be a VM bug but a leak or poor handling of kernel
> allocations somewhere. Sadly the changes needed to do that (beancounter
> patch) were things Linus never accepted for 2.4
> 

Well, if you can't fork a new process because that would push you into
overcommit, then you usually can't actually do anything useful on the
machine.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
