Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbTHTSOr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 14:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbTHTSOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 14:14:46 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:30213 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262133AbTHTSOp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 14:14:45 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: DVD ROM on 2.6
Date: 20 Aug 2003 18:06:31 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bi0db7$err$1@gatekeeper.tmr.com>
References: <200308192009.11298.admin@kentonet.net>
X-Trace: gatekeeper.tmr.com 1061402791 15227 192.168.12.62 (20 Aug 2003 18:06:31 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200308192009.11298.admin@kentonet.net>,
Bryan D. Stine <admin@kentonet.net> wrote:

| Try passing the -t iso9660 option to mount or (if that doesn't work) you
|  could go so far as to removing the UDF support from the kernel.
| 
| On Tuesday 19 August 2003 07:34 pm, Wakko Warner wrote:
| > I'm trying out 2.6 on one of my test boxes with an IDE dvd drive.  I'm
| > using ide-scsi (I prefer scdx as opposed to hdx).  I noticed that any
| > attempt to mount a DVD movie (lord of the rings comes to mind) it mounts as
| > UDF.  My laptop mounts this same dvd as iso9660.
| >
| > I've also been unable to play DVDs on this machine, but I don't have the
| > same packages installed as I do on my laptop.

If iso9660 looks enough like UDF to confuse the f/s typing logic, would
the problem go away if the iso9660 were checked first? It seems iso9660
can be mistaken for UDF, is the converse true?

In any case it can be set explicitly.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
