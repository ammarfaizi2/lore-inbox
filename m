Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288333AbSAMX54>; Sun, 13 Jan 2002 18:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288334AbSAMX5h>; Sun, 13 Jan 2002 18:57:37 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:40204 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288333AbSAMX5W>; Sun, 13 Jan 2002 18:57:22 -0500
Subject: Re: Getting Out of Memory errors at random intervals.
To: abrink@ns.brink.cx (Andrew Brink)
Date: Mon, 14 Jan 2002 00:09:14 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20020113233647.GA1198@ns.brink.cx> from "Andrew Brink" at Jan 13, 2002 05:36:47 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Pugc-0008QL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, Jan 13, 2002 at 11:45:42PM +0000, Alan Cox wrote:
> > Run something that has a sane VM in all the known awkward cases (eg the Red Hat
> > 2.4.9 tree) and you should be just fine. If not I'd be interested to know
> 
> I take it the vanilla 2.4.9 would also do?

Nothing like it. The 2.4.9-RH tree is very different VM wise from the 2.4.9
base tree. Linus never took the VM updates from it.

> > Andrea -aa vm patches or Rik's rmap-11b patch. Both of which seem to help
> > no end.
> 
> As for High loads....these boxes don't even get a load.

I suspect they are - possibly only a sudden sharp burst of web traffic
causing a lot of cgi/mysql/apache process activity.

Alan
