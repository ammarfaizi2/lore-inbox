Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbQLaPbP>; Sun, 31 Dec 2000 10:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129776AbQLaPbF>; Sun, 31 Dec 2000 10:31:05 -0500
Received: from tomts8.bellnexxia.net ([209.226.175.52]:48056 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129401AbQLaPaz>; Sun, 31 Dec 2000 10:30:55 -0500
From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: test13-pre7...
To: linux-kernel@vger.kernel.org
Date: Sun, 31 Dec 2000 10:00:07 -0500
Organization: me
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: KNode/0.3.3
Message-Id: <20001231150008.97F705E18A@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Evans wrote:

> On Sat, 30 Dec 2000, Linus Torvalds wrote:
> 
> > On Sat, 30 Dec 2000, Steven Cole wrote:
> > >
> > > It looks like 2.4.0-test13-pre7 is a clear winner when running dbench
> > > 48 on my somewhat slow test machine (450 Mhz P-III, 192MB, IDE).
> >
> > This is almost certainly purely due to changing (some would say
> > "fixing") the bdflush synchronous wait point.
> 
> Nice:)
> 
> Did Rik's drop_behind performance fix make it in or can we look forward to
> another jump in the dbench benchmarks?

And please do not forget marcello's swap clustering patch.  I get a 13% 
improvement on dbench with reiserfs when patched with it.  From 
conversations on kernelnewbies, Riel likes this one too.

Ed Tomlinson


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
