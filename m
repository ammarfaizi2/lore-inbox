Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129868AbQLEWQQ>; Tue, 5 Dec 2000 17:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129853AbQLEWP6>; Tue, 5 Dec 2000 17:15:58 -0500
Received: from 194-73-188-168.btconnect.com ([194.73.188.168]:57096 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129525AbQLEWPs>;
	Tue, 5 Dec 2000 17:15:48 -0500
Date: Tue, 5 Dec 2000 21:46:58 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Peter Samuelson <peter@cadcamlab.org>
cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test12-pre5 breaks vmware (again)
In-Reply-To: <20001205153900.F6567@cadcamlab.org>
Message-ID: <Pine.LNX.4.21.0012052144010.1683-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2000, Peter Samuelson wrote:

> [Tigran Aivazian]
> > I think 'flags' is what it used to be called ages ago but that is
> > irrelevant -- everyone presumably already changed all their software
> > to use 'features' (I did, for example) and forgot about the old
> > 'flags' forever....
> 
> Ages ago?  s/flags/features/ happened in test11pre5.  I doubt most of
> the world had switched yet.

well, if you look very carefully you will see a missing \t so the new
value of that field in the /proc/cpuinfo at the moment is quite unique :)
(but Hugh Dickins, I think, posted a patch today which fixes this)

(yes, I know that the vmware script (especially Petr's latest
version) deals correctly with any combination of features/flags with and
without tabs).

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
