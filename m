Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261488AbREQSx3>; Thu, 17 May 2001 14:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261492AbREQSxT>; Thu, 17 May 2001 14:53:19 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:18702 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261490AbREQSxK>; Thu, 17 May 2001 14:53:10 -0400
Message-ID: <3B041E06.BF5155ED@transmeta.com>
Date: Thu, 17 May 2001 11:52:54 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.4 failure to compile
In-Reply-To: <Pine.LNX.3.95.1010517144217.2854A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> I have both. I also have `flex`, but not `lex'. `lex' is a simlink to
> flex. What this compile wanted is some header files in expects for
> `yacc` that are not present. And they don't come with the `bison`
> distribution. Maybe they came with `yacc` years ago? Anyway there
> are some poor assumptions being made in the source Makefile.
> 
> It would be nice to have the 'microcode' assembler running for
> aic7xxx since it is now required for the thing to load.
> 

It worked just fine with "bison" here (with the appropriate shell script
added.)

I think the header file you're talking about is the db1 header file,
which has nothing to do with yacc -- it's the Berkeley libdb version 1,
which is a pretty bad thing to require.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
