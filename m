Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318770AbSHLRd4>; Mon, 12 Aug 2002 13:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318771AbSHLRdz>; Mon, 12 Aug 2002 13:33:55 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:9982 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318770AbSHLRcp>; Mon, 12 Aug 2002 13:32:45 -0400
Subject: Re: via vp3 udma corruption
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ed Sweetman <safemode@speakeasy.net>
Cc: linux-kernel@vger.kernel.org, David Fries <dfries@mail.win.org>
In-Reply-To: <1029173401.19308.98.camel@psuedomode>
References: <20020811210826.GA684@spacedout.fries.net> 
	<20020812170232.GC15249@kroah.com>  <1029173401.19308.98.camel@psuedomode>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 12 Aug 2002 18:33:39 +0100
Message-Id: <1029173619.16216.194.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-12 at 18:30, Ed Sweetman wrote:
> Perhaps we all see udma corruption due to it detecting an udma speed
> that's not supported by our chipsets?  I know my manual says UDMA66 is
> the highest for my board.  

That would suprise me since the link is CRC protected. It is always
possible if we are accidentally overconfiguring a chip, although I'd
expect a prompt and total failure.

One for the VIA IDE maintainer

