Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262599AbREOBrs>; Mon, 14 May 2001 21:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262601AbREOBr2>; Mon, 14 May 2001 21:47:28 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:32014 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262599AbREOBrS>; Mon, 14 May 2001 21:47:18 -0400
Message-ID: <3B008A87.77607AA4@transmeta.com>
Date: Mon, 14 May 2001 18:46:47 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.4 kernel reports wrong amount of physical memory
In-Reply-To: <200105142250.f4EMoHt02203@adsl-209-76-109-63.dsl.snfc21.pacbell.net> <Pine.LNX.4.33.0105142025000.18102-100000@duckman.distro.conectiva> <9dpt1e$185$1@cesium.transmeta.com> <3B008D00.A201D690@didntduck.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:
> >
> > It seems obvious once you know why the limits are there.  The 1 GB
> > limit (actually 1024-128 MB = 896 MB) is a software limit; the 4 GB
> > and 64 GB limits are hardware limits and are exact.
> 
> Even with the 4GB and 64GB options, some physical address space has to
> be reserved for memory mapped I/O.
> 

Oh, right.  It's not just virtual address space.  Geez, I'm being really
dense today :)

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
