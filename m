Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283205AbRLDTvD>; Tue, 4 Dec 2001 14:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281668AbRLDRgJ>; Tue, 4 Dec 2001 12:36:09 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2053 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281450AbRLDRfW>; Tue, 4 Dec 2001 12:35:22 -0500
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
To: esr@thyrsus.com
Date: Tue, 4 Dec 2001 17:44:19 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, hch@caldera.de (Christoph Hellwig),
        kaos@ocs.com.au (Keith Owens), kbuild-devel@lists.sourceforge.net,
        torvalds@transmeta.com
In-Reply-To: <20011204120305.A16578@thyrsus.com> from "Eric S. Raymond" at Dec 04, 2001 12:03:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BJcB-0002o7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After CML2 has proven itself in 2.5, I do plan to go back to Marcelo
> and lobby for him accepting it into 2.4, on the grounds that doing so
> will simplify his maintainance task no end.  That's why I'm tracking
> both sides of the fork in the rulebase, so it will be an easy drop-in
> replacement for Marcelo as well as Linus.

Thats somewhat impractical. You will break all the existing additional
configuration tools for the 2.4 stable tree that people expect to continue
to work

Breaking them in 2.5 isnt a big issue, but breaking stable kernel trees
is a complete nono
