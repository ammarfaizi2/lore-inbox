Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263742AbTKFTZA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 14:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263745AbTKFTY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 14:24:59 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:37386 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263742AbTKFTY6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 14:24:58 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
Date: 6 Nov 2003 19:14:31 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <boe6in$f4q$1@gatekeeper.tmr.com>
References: <3FA69CDF.5070908@gmx.de> <20031105100120.GH1477@suse.de> <3FA8CCF9.6070700@gmx.de> <20031105101207.GI1477@suse.de>
X-Trace: gatekeeper.tmr.com 1068146071 15514 192.168.12.62 (6 Nov 2003 19:14:31 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031105101207.GI1477@suse.de>, Jens Axboe  <axboe@suse.de> wrote:

| k3b is probably still going through ide-scsi which you must not. It
| would be interesting if you could try without ide-scsi and use cdrecord
| manually (maybe someone more knowledgable on k3b can common on whether
| they support 2.6 or not). 2.6 will be a lot faster than 2.4.

I'm not sure what you mean by faster, burning runs at device limited
speed in CPU time in the  less than 1% range if you remember to enable
DMA. The last time I looked DMA didn't work in either kernel if write
size was not a multiple of 1k, (or 2k?) has that changed?

I'm not sure what you meant by faster, so don't think I'm disagreeing
with you.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
