Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316535AbSILS6e>; Thu, 12 Sep 2002 14:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316677AbSILS6e>; Thu, 12 Sep 2002 14:58:34 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:53737 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316535AbSILS6d>; Thu, 12 Sep 2002 14:58:33 -0400
Subject: RE: Killing/balancing processes when overcommited
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: linux-kernel@vger.kernel.org, Giuliano Pochini <pochini@shiny.it>,
       riel@conectiva.com.br
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFDB91827C.152E85A4-ON88256C32.0067C0A4@boulder.ibm.com>
From: "Jim Sibley" <jlsibley@us.ibm.com>
Date: Thu, 12 Sep 2002 12:00:33 -0700
X-MIMETrack: Serialize by Router on D03NM801/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 09/12/2002 01:01:14 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The mem eaters may not be the ones really "causing the problem" as
determined by the installation. The case where I discovered this was when
someone was asking for a lot of small chunks of memory (legitemately). So
you would need a history and a total memory usage to identify who this is.
And this is not really just limited to memory.

I still favor an installation file in /etc specifying the order in which
things are to be killed. Any alogrithmic assumptions are bound to fail at
some point to the dissatisfaction of the installation.

And this is not just limited to memory exhaustion. For example, if I exceed
the maximum number of files, I can't log on to fix the problem. If the
installation could set some priorities, they could say who to sacrifice in
order to keep others running.

Regards, Jim
Linux S/390-zSeries Support, SEEL, IBM Silicon Valley Labs
t/l 543-4021, 408-463-4021, jlsibley@us.ibm.com
*** Grace Happens ***



