Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261474AbREQSdU>; Thu, 17 May 2001 14:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261476AbREQSdJ>; Thu, 17 May 2001 14:33:09 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:31245 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261474AbREQSc6>; Thu, 17 May 2001 14:32:58 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Linux-2.4.4 failure to compile
Date: 17 May 2001 11:32:41 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9e15g9$tcj$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.3.95.1010517132052.14991A-100000@chaos.analogic.com> <3B040C80.C2A7BC6@sun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3B040C80.C2A7BC6@sun.com>
By author:    Tim Hockin <thockin@sun.com>
In newsgroup: linux.dev.kernel
> 
> The aic7xxx assembler requiring libdb1 is a bungle.  Getting the headers
> for that right on various distros is not easy.  Add to that it requires
> YACC, when most people have bison (yes, a shell script is easy to make, but
> not always an option). 
> 

Most people have both.  However, if your distribution installs bison
and not yacc and does *NOT* install the "bison as yacc" wrapper, you
should complain to your distributor.

As far as "not always an option", that's ridiculous.  If there really
isn't someone around who can install it globally, then put it in ~/bin
and set your PATH.

The command "yacc" should be expected to work.  This is as insane as
the flamage in the cdrecord documentation about Linux installing GNU
make as "make".

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
