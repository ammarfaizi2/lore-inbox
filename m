Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314491AbSE0Iee>; Mon, 27 May 2002 04:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314512AbSE0Ied>; Mon, 27 May 2002 04:34:33 -0400
Received: from adsl-66-136-200-16.dsl.austtx.swbell.net ([66.136.200.16]:51841
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S314491AbSE0Ied> convert rfc822-to-8bit; Mon, 27 May 2002 04:34:33 -0400
Subject: Re: RT Sigio broken on 2.4.19-pre8
From: Austin Gonyou <austin@digitalroadkill.net>
To: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Cc: Aaron Sethman <androsyn@ratbox.org>, linux-kernel@vger.kernel.org
In-Reply-To: <3CF1ED6D.1030202@loewe-komp.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Organization: http://www.digitalroadkill.net
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 27 May 2002 03:34:08 -0500
Message-Id: <1022488448.27419.21.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahh...yes..I see a few apps exhibiting bad behaviour because of RT Sigio
not working. :(

Anyone know if it's fixed in -aa3?(i'm using -aa2)

RedCarpet seems to be a primary exhibitor on my desktop box.

On Mon, 2002-05-27 at 03:25, Peter Wächtler wrote:
> Aaron Sethman wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > 
> > Using the Dan Kegel's Poller_bench utility I noticed that RT SIGIO is not
> > working on 2.4.19-pre8.  Basically sigtimedwait() is always returning
> > SIGIO.  Note that 2.4.18 works fine.
> > 
> 
> What is this Poller_bench and where do I get it?
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
