Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267411AbTALTUS>; Sun, 12 Jan 2003 14:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267412AbTALTUS>; Sun, 12 Jan 2003 14:20:18 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:40086
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267411AbTALTUQ>; Sun, 12 Jan 2003 14:20:16 -0500
Subject: Re: [PATCH] add explicit Pentium II support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Love <rml@tech9.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, L.A.van.der.Duim@student.rug.nl,
       akpm@digeo.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1042398209.834.59.camel@phantasy>
References: <1042398209.834.59.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042402563.16288.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 12 Jan 2003 20:16:04 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-12 at 19:03, Robert Love wrote:
> This patch is by Luuk van der Duim with some changes by me (primarily to
> also support the pre-Coppermine Celeron chips, since those use Pentium
> II cores).  This patch has been in 2.5-mm for awhile and Andrew ack'ed
> this submission.

Looks good. Might also be good to clarify in the help whether the PII/PIII
option also skips using lock decb for the spinlocks and the other fence
workarounds for the PPro fence errata. 

Alan

