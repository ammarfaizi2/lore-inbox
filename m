Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132125AbRCVSO1>; Thu, 22 Mar 2001 13:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132128AbRCVSOS>; Thu, 22 Mar 2001 13:14:18 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:47781 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S132125AbRCVSON> convert rfc822-to-8bit; Thu, 22 Mar 2001 13:14:13 -0500
Message-Id: <l03130302b6dfea87c17f@[192.168.239.101]>
In-Reply-To: <Pine.LNX.4.21.0103221334570.21415-100000@imladris.rielhome.conectiva>
In-Reply-To: <x88zoeeeyh8.fsf@adglinux1.hns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Date: Thu, 22 Mar 2001 18:12:47 +0000
To: Rik van Riel <riel@conectiva.com.br>, nbecker@fred.net
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: regression testing
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>- automated heavy stress testing

This would be an interesting one to me, from a benchmarking POV.  I'd like
to know what my hardware can really do, for one thing - it's all very well
saying this box can do X Whetstones and has a 100Mbit NIC, but it's a much
more solid thing to be able to say "my box handled the official Foobar
stress-test in Y hours, handling Z widgets per second".

The lmbench statistics are nice, but most of those numbers mean absolutely
nothing to all but übergeeks (what they say to my partially-trained ears is
that my gateway box sucks, but then again it's five-year-old Intel hardware
so that could probably have been predicted).  Are there already
stress-testing kits for user-level processes I could play with?

What would be *really* interesting would be to make such tests as portable
as practical, so that at least some of them can be run on "rival platforms"
(such as *cough* Redmondware) to see if they stand up to the challenge as
well.

However, if the focus is on *kernel* stress-testing, portability might be a
little difficult to arrange for many tests.  The basics could probably be
written portably or ported easily, though - things that lmbench already
(briefly) benchmarks, for example.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
-----END GEEK CODE BLOCK-----


