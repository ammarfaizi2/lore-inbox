Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317661AbSHLJSd>; Mon, 12 Aug 2002 05:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317668AbSHLJSd>; Mon, 12 Aug 2002 05:18:33 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:61456 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S317661AbSHLJSc>; Mon, 12 Aug 2002 05:18:32 -0400
Message-ID: <3D577EA6.204E670D@aitel.hist.no>
Date: Mon, 12 Aug 2002 11:23:50 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.30 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: large page patch (fwd) (fwd)
References: <Pine.LNX.4.44L.0208091317220.23404-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

> One problem we're running into here is that there are absolutely
> no tools to measure some of the things rmap is supposed to fix,
> like page replacement.
> 
There are things like running vmstat while running tests or production.

My office desktop machine (256M RAM) rarely swaps more than 10M
during work with 2.5.30.  It used to go some 70M into swap
after a few days of writing, browsing, and those updatedb runs.  

Helge Hafting
