Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271005AbRJMX3t>; Sat, 13 Oct 2001 19:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271714AbRJMX3j>; Sat, 13 Oct 2001 19:29:39 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61712 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271005AbRJMX3c>; Sat, 13 Oct 2001 19:29:32 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Maximum size of ext2 files on ia32 is?
Date: 13 Oct 2001 16:29:30 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9qaioq$5vb$1@cesium.transmeta.com>
In-Reply-To: <3BC8AE84.48808982@sgi.com> <1003013547.14180.1.camel@ogre> <3BC8C86D.4C48828C@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3BC8C86D.4C48828C@sgi.com>
By author:    L A Walsh <law@sgi.com>
In newsgroup: linux.dev.kernel
> 
> 	Hmmm.  I have a server at work installed from RH7.1 running 2.4.4.
> I did a grep of many files into redirected into a file and that fails at
> 2G.  But my version of 7.2 Suse doesn't.  I take it this is a recent update
> to the file utils?
> 

No, it's a matter of if the distributor, who compiled fileutils,
compiled with -D_FILE_OFFSET_BITS=64 or not.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
