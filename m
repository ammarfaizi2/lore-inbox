Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265058AbTLCQUu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 11:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265071AbTLCQUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 11:20:50 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:25098 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S265058AbTLCQUq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 11:20:46 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: ide-cd 2.6.0-test11 does not work
Date: 3 Dec 2003 16:09:37 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bql1s1$i31$1@gatekeeper.tmr.com>
References: <20031202163856.GA16759@thumper2.emsphone.com> <200312022026.47485.bzolnier@elka.pw.edu.pl>
X-Trace: gatekeeper.tmr.com 1070467777 18529 192.168.12.62 (3 Dec 2003 16:09:37 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200312022026.47485.bzolnier@elka.pw.edu.pl>,
Bartlomiej Zolnierkiewicz  <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
| 
| Do you have IDE CD support compiled-in or as module (ide-cd)?

I'm assuming that since OP said "loaded" that it was as a module.
| 
| --bart
| 
| On Tuesday 02 of December 2003 17:38, Andrew Ryan wrote:
| > The docs say I shouldn't need ide-scsi anymore, but ide-scsi is the only
| > way I can mount cds.  If I try mount /dev/hdc /mnt I get /dev/hdc is not a
| > valid block device.  After loading ide-scsi, mount /dev/sr0 /mnt works fine
| > (though if I rip music cds with xcdroast the system locks up, ide-scsi
| > related oops).  This is on a hp zd7000 notebook with a dvd/cd-rw
| > (HL-DT-STCD-RW/DVD DRIVE GCC-4241N).

Andrew, the recent patch from Linus seems to have fixed a lot of oopsen,
has it cured yours?
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
