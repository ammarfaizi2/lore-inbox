Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263206AbTDNNeb (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 09:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263207AbTDNNea (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 09:34:30 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:44217
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263206AbTDNNe2 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 09:34:28 -0400
Subject: Re: [PATCH] M68k IDE updates
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: paulus@samba.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <16025.63003.968553.194791@nanango.paulus.ozlabs.org>
References: <200304131306.h3DD6XQ3001331@callisto.of.borg>
	 <1050243002.24186.7.camel@dhcp22.swansea.linux.org.uk>
	 <16025.63003.968553.194791@nanango.paulus.ozlabs.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050324480.25621.62.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Apr 2003 13:48:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-04-14 at 00:43, Paul Mackerras wrote:
> Since __ide_mm_insw doesn't get told whether it is transferring normal
> sector data or drive ID data, it can't necessarily do the right thing
> in both situations.

That may be the right change to make.

> It's very possible that there are some PPC platforms for which IDE is
> borken right now - I strongly suspect this would be the case for the
> Tivo at least, and probably several other embedded PPC platforms.

For the older tivo that would be sad, for the newer tivo where they
digitally sign the binary and don't provide the signatures -- too bad
they are violating the license clarifications on the IDE code if they
use it.

Alan

