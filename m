Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316567AbSGATi0>; Mon, 1 Jul 2002 15:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316569AbSGATi0>; Mon, 1 Jul 2002 15:38:26 -0400
Received: from mail.s3.kth.se ([130.237.48.5]:63504 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S316567AbSGATiZ>;
	Mon, 1 Jul 2002 15:38:25 -0400
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: jlnance@intrex.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-rc1 broke OSF binaries on alpha
References: <Pine.LNX.4.44.0206281730160.12542-100000@freak.distro.conectiva>
	<E17O7yk-0007w5-00@the-village.bc.nu>
	<20020630035058.A884@localhost.park.msu.ru>
	<20020701090353.B1957@tricia.dyndns.org>
	<20020701180252.A15288@jurassic.park.msu.ru>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 01 Jul 2002 21:40:48 +0200
In-Reply-To: Ivan Kokshaysky's message of "Mon, 1 Jul 2002 18:02:52 +0400"
Message-ID: <yw1xvg7z1bjz.fsf@gladiusit.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky <ink@jurassic.park.msu.ru> writes:

> On Mon, Jul 01, 2002 at 09:03:53AM -0400, jlnance@intrex.net wrote:
> > So how does Tru64 handle this?  It must have some way of knowing whether to
> > mask the high bits or not.
> 
> No idea. Not sure if it handles this at all. Maybe you
> just have to recompile.
> 
> > If the comment above is correct then this patch
> > breaks new Tru64 binaries.
> 
> Last time I checked Tru64 v5.0 and above binaries didn't worked
> under Linux for other reasons (missing libraries or something like that).

Using the libraries from the tru64 5.0 install CD works fine for
running programs on that CD. There does seem to be some problems with
different library versions, though. Matlab 5 would not run with libc
from the tru64 5.0 CD. I had to get some other ones. With the right
libraries Matlab runs fine with both 2.4.19-rc1 and earlier.

-- 
Måns Rullgård
mru@users.sf.net
