Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbTKGWOs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbTKGWOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:14:04 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:44812 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264393AbTKGPQr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 10:16:47 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: ide-scsi "lost interrupt" (2.6.0-test9)
Date: 7 Nov 2003 15:06:19 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bogcdb$l14$1@gatekeeper.tmr.com>
References: <20031028230910.GM32594@ruvolo.net>
X-Trace: gatekeeper.tmr.com 1068217579 21540 192.168.12.62 (7 Nov 2003 15:06:19 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031028230910.GM32594@ruvolo.net>,
Chris Ruvolo  <chris+lkml@ruvolo.net> wrote:

| When attempting to use cdrecord under 2.6.0-test9 with a ide-scsi ATAPI
| device, the burn fails and I get the following kernel output.  This has
| happened both times I tried to burn a CD, at both 4x and 2x write.  This is
| with DMA disabled via "/sbin/hdparm -d 0 /dev/hdc".
| 
| Any advise here?  (cdrecord with -dev=ATAPI doesn't seem to work)

You probably need a newer version of cdrecord for that. Read on.

| BTW, there doesn't seem to be a maintainer for the ide-scsi module.  Is that
| correct?

AFAIK.

| Also, there's another ide-scsi problem I just noticed.  When unloading the
| ide-scsi module and reloading it, it gets assigned a new bus.  On the
| initial load my CD device as -dev=0,0,0.  Now it is -dev=2,0,0.  The code to
| unregister the bus seems to have been removed between -test1 and -test9.
| Can anyone say why?

I think that's a kernel feature in general, if I unplug and replug my
USB flash reader I get a new bus as well.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
