Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288422AbSANAb6>; Sun, 13 Jan 2002 19:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288435AbSANAbx>; Sun, 13 Jan 2002 19:31:53 -0500
Received: from cj379137-a.indpdnce1.mo.home.com ([24.179.182.153]:42756 "EHLO
	ns.brink.cx") by vger.kernel.org with ESMTP id <S288422AbSANAaw>;
	Sun, 13 Jan 2002 19:30:52 -0500
From: Andrew Brink <abrink@ns.brink.cx>
Date: Sun, 13 Jan 2002 18:30:32 -0600
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Getting Out of Memory errors at random intervals.
Message-ID: <20020114003032.GA1356@ns.brink.cx>
In-Reply-To: <20020113233647.GA1198@ns.brink.cx> <E16Pugc-0008QL-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16Pugc-0008QL-00@the-village.bc.nu>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 12:09:14AM +0000, Alan Cox wrote:
> > On Sun, Jan 13, 2002 at 11:45:42PM +0000, Alan Cox wrote:
> > > Run something that has a sane VM in all the known awkward cases (eg the Red Hat
> > > 2.4.9 tree) and you should be just fine. If not I'd be interested to know
> > 
> > I take it the vanilla 2.4.9 would also do?
> 
> Nothing like it. The 2.4.9-RH tree is very different VM wise from the 2.4.9
> base tree. Linus never took the VM updates from it.

Okay. Will do.

> 
> > > Andrea -aa vm patches or Rik's rmap-11b patch. Both of which seem to help
> > > no end.
> > 
> > As for High loads....these boxes don't even get a load.
> 
> I suspect they are - possibly only a sudden sharp burst of web traffic
> causing a lot of cgi/mysql/apache process activity.

*Shrug* I've done some experimenting with this, having a lab (30 people)
all hit the site at the same time. Holds it fine most the time.  Usually
the OOM's come during the middle of the night.

> 
> Alan
