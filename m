Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271543AbTGQVjk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 17:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271574AbTGQViZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 17:38:25 -0400
Received: from ms-smtp-02.rdc-kc.rr.com ([24.94.166.122]:53689 "EHLO
	ms-smtp-02.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S271568AbTGQVgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 17:36:53 -0400
Date: Thu, 17 Jul 2003 16:51:39 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: debian-user <debian-user@lists.debian.org>
Subject: 2.6.0-test1: some modules refuse to autoload
Message-ID: <20030717215139.GA19877@glitch.localdomain>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>,
	debian-user <debian-user@lists.debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My apologies if this is a repeat... I originally sent it yesterday
evening, and haven't seen any sign of it on the list.

---

I'm starting to test out the 2.6.0-test1 kernel, and for the most part
everything is going smoothly.  There is one problem that has me
stumped, however... I can't seem to get module auto-loading to work for
the cdrom.  None of the other modules seem to have any trouble.

I'm currently running Debian sid, with module-init-tools 0.9.13-pre.
I've defined the alias "block-major-22 ide-cd", and verified that both
"modprobe -nv block-major-22" and "modprobe -nv ide-cd" give the
expected results.  When I try to mount a CD, however, I get the message
"/dev/hdc not a valid block device".  Browsing the system logfiles, I
don't see any indication that a module load was even attempted.
Everything works fine if I load the ide-cd module manually first.

I browsed the list archives and did some googling, but didn't find
anything which sounded similar.  Any idea what's wrong?

Thanx!
