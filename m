Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272305AbRIEU0T>; Wed, 5 Sep 2001 16:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272309AbRIEU0J>; Wed, 5 Sep 2001 16:26:09 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59151 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272305AbRIEUZ7>; Wed, 5 Sep 2001 16:25:59 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: getpeereid() for Linux
Date: 5 Sep 2001 13:26:09 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9n61p1$k5e$1@cesium.transmeta.com>
In-Reply-To: <200109051551.KAA48912@tomcat.admin.navo.hpc.mil> <tgd755vdl9.fsf@mercury.rus.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <tgd755vdl9.fsf@mercury.rus.uni-stuttgart.de>
By author:    Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
In newsgroup: linux.dev.kernel
> 
> I need the credentials only for local connections, though.  This is
> technically possible.  A userspace implementation partially cloning
> ident seems to be a possible approach.
> 

Since it will only work locally anyway, just use a Unix domain socket
-- that's what they're for.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
