Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314381AbSESMsX>; Sun, 19 May 2002 08:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314403AbSESMsW>; Sun, 19 May 2002 08:48:22 -0400
Received: from e.kth.se ([130.237.48.5]:43021 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S314381AbSESMsV>;
	Sun, 19 May 2002 08:48:21 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: ide cd/dvd with 2.4.19-pre8
In-Reply-To: <yw1x1ycak586.fsf@gladiusit.e.kth.se>
	<200205191219.g4JCJ7Y25884@Port.imtp.ilyichevsk.odessa.ua>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 19 May 2002 14:48:19 +0200
Message-ID: <yw1xn0uwz4ks.fsf@spirello.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> writes:

> On 17 May 2002 16:18, M?ns Rullg?rd wrote:
> > I just noticed that reading from both my cdrom and dvd is a lot slower
> > with 2.4.19-pre8 than 2.4.18. Now hdparm reports ~800 kbytes/s compared to
> > 1.7 MBytes/s for CD and >2 MBytes/s for DVD with 2.4.18. It is even
> > impossible to play DVDs. Any ideas?
> 
> Do you know at which preN this has happened?

No, and really don't have the time to try them all just to find out.
I do suspect it is related to the major changes in the ide drivers and
particularly pdc202xx.c.

-- 
Måns Rullgård
mru@users.sf.net
