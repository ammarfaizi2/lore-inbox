Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261911AbREOQFc>; Tue, 15 May 2001 12:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261910AbREOQFW>; Tue, 15 May 2001 12:05:22 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:39948 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261405AbREOQFN>; Tue, 15 May 2001 12:05:13 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Device Numbers, LILO
Date: 15 May 2001 09:04:55 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9drk37$51s$1@cesium.transmeta.com>
In-Reply-To: <20010515121635.B5C402F84AC@www.topmail.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010515121635.B5C402F84AC@www.topmail.de>
By author:    mirabilos <eccesys@topmail.de>
In newsgroup: linux.dev.kernel
>
> >That's not the issue.  LILO takes whatever you pass to root= and converts
> >it to a device number at /sbin/lilo time.  An idiotic practice on the
> >part of LILO, in my opinion, that ought to have been fixed a long time
> >ago.
> 
> That's why you have to use append="root=blah" for devfs :)
> Really it should have been in IMO. Btw, is LBA support in?
> Last time I saw a LILO manpage it stated that "linear" still
> is restricted to 16bit (65535 sectors) which normally is much
> less than 1k cylinders...
> 

It's in, but for some strange reason you have to ask for it explicitly
with the "lba32" option.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
