Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271313AbTGWUvN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 16:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271316AbTGWUvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 16:51:13 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:19464 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S271313AbTGWUvL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 16:51:11 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.0-test1: some modules refuse to autoload
Date: 23 Jul 2003 20:58:45 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bfmsu5$l2k$1@gatekeeper.tmr.com>
References: <20030717215139.GA19877@glitch.localdomain>
X-Trace: gatekeeper.tmr.com 1058993925 21588 192.168.12.62 (23 Jul 2003 20:58:45 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030717215139.GA19877@glitch.localdomain>,
Greg Norris  <haphazard@kc.rr.com> wrote:

| I'm currently running Debian sid, with module-init-tools 0.9.13-pre.
| I've defined the alias "block-major-22 ide-cd", and verified that both
| "modprobe -nv block-major-22" and "modprobe -nv ide-cd" give the
| expected results.  When I try to mount a CD, however, I get the message
| "/dev/hdc not a valid block device".  Browsing the system logfiles, I
| don't see any indication that a module load was even attempted.
| Everything works fine if I load the ide-cd module manually first.

Is hdd set to anything special? And is hdc set to cdrom? If not, try an
explicit "hdc=cdrom" on the boot line. I have had to do this on several
systems, in spite of dmesg telling me the kernel knows that it's a CD.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
