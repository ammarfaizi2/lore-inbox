Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129847AbRCATtd>; Thu, 1 Mar 2001 14:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129848AbRCATtY>; Thu, 1 Mar 2001 14:49:24 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:7435 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129847AbRCATtL> convert rfc822-to-8bit; Thu, 1 Mar 2001 14:49:11 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Escape sequences & console
Date: 1 Mar 2001 11:48:39 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <97m92n$hpm$1@cesium.transmeta.com>
In-Reply-To: <"3a9e8dcd3b72e6a5@amyris.wanadoo.fr> <Pine.LNX.4.31.0103011919490.23240-100000@phobos.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id LAA28653
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.31.0103011919490.23240-100000@phobos.fachschaften.tu-muenchen.de>
By author:    Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>
In newsgroup: linux.dev.kernel
>
> On Thu, 1 Mar 2001, Sébastien HINDERER wrote:
> 
> > Could someone tell me where I can find a document listing all the
> > escape-sequences that could be sent to the console (/dev/console) and what
> > they do.
> 
> Please don't use those sequences directly, as not everyone has
> /dev/console on a vt. You can find the information you want in your local
> terminfo database under "linux".
> 

Well, don't use them directly without checking that $TERM is "linux".
Also, normally they should be sent to the current terminal (/dev/tty,
or just stdout) rather than /dev/console.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
