Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288060AbSAHOTi>; Tue, 8 Jan 2002 09:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288061AbSAHOT2>; Tue, 8 Jan 2002 09:19:28 -0500
Received: from mail.fenster-world.de ([62.159.82.131]:60349 "EHLO
	imhotep.aubi.de") by vger.kernel.org with ESMTP id <S288060AbSAHOTV>;
	Tue, 8 Jan 2002 09:19:21 -0500
Message-ID: <7B1EED0C5D58D411B73200508BDE77B2C53D51@EXCHANGEB>
From: =?iso-8859-1?Q?Markus_D=F6hr?= <doehrm@aubi.de>
To: "'J.A. Magallon'" <jamagallon@able.es>,
        =?iso-8859-1?Q?=27Dieter_N=FC?= =?iso-8859-1?Q?tzel=27?= 
	<Dieter.Nuetzel@hamburg.de>
Cc: "'Marcelo Tosatti'" <marcelo@conectiva.com.br>,
        "'Andrea Arcangeli'" <andrea@suse.de>,
        "'Rik van Riel'" <riel@conectiva.com.br>,
        "'Linux Kernel List'" <linux-kernel@vger.kernel.org>,
        "'Andrew Morton'" <akpm@zip.com.au>, "'Robert Love'" <rml@tech9.net>
Subject: RE: [2.4.17/18pre] VM and swap - it's really unusable
Date: Tue, 8 Jan 2002 15:22:41 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to throw in my EUR 0.02:

We're using 2.4.17-rc2aa2 on a quite huge database server. This is the most
stable and performant kernel IMHO since we tested the new 2.4.>10 series. 

The machine has 4 GB main memory, the DB process mallocs about 3 GB memory
spawning about 150 threads. "Older" kernels had the problem that short after
logging in the machine starts heavily swapping leaving the system unusable
for minutes.

2.4.17-rc2aa2 does not have this problem (since now) - even under DB loads >
15 the system is still responsive.

Good Work!


-- 
Markus Doehr            AUBI Baubschlaege GmbH
IT Admin/SAP R/3 Basis  Zum Grafenwald
fon: +49 6503 917 152   54411 Hermeskeil
fax: +49 6503 917 190   http://www.aubi.de 
