Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315430AbSGMU2K>; Sat, 13 Jul 2002 16:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315431AbSGMU2J>; Sat, 13 Jul 2002 16:28:09 -0400
Received: from pD9E23254.dip.t-dialin.net ([217.226.50.84]:50050 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315430AbSGMU2J>; Sat, 13 Jul 2002 16:28:09 -0400
Date: Sat, 13 Jul 2002 14:30:12 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: What is supposed to replace clock_t?
In-Reply-To: <200207132015.g6DKFsH103416@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.44.0207131425301.3331-100000@hawkeye.luckynet.adm>
X-Location: Potsdam; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 13 Jul 2002, Albert D. Cahalan wrote:
> foo   some value
> bar   1 2 3 4 5
> baz   8000:0
> 
> Then it turned into this:
> 
> foo   : some value
> bar   : 1 2 3 4 5
> baz   : 8000:0
> uh oh : 69

$buf = <MyFile>;
$buf =~ s/\s*\:\s*/\t/g;
printf("%s\n", $buf);

This should bring you back the old tab-delimited format. Use it to fix 
your parsers.

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

