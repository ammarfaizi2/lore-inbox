Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbVFLGvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbVFLGvM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 02:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbVFLGvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 02:51:12 -0400
Received: from web30704.mail.mud.yahoo.com ([68.142.200.137]:3688 "HELO
	web30704.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261888AbVFLGu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 02:50:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=t2b8EWhwHDLbRUM3NIX211syt+qUHoer9TsWqRUIiodi/eLV/dFmDXw9q1J3jUKyBOGR+8IP+fqj4RWC+GlKXOa9PNnIeEF/7GPbnuuvB+F7BN6wgZmVeyQwkjWG+e+pwui7bkhz35KDx/42TKjeN97JBZQPuxug9wxGcem8A2s=  ;
Message-ID: <20050612065050.99998.qmail@web30704.mail.mud.yahoo.com>
Date: Sat, 11 Jun 2005 23:50:50 -0700 (PDT)
From: subbie subbie <subbie_subbie@yahoo.com>
Subject: optional delay after partition detection at boot time
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 I'm sure some of you have come across this annoying
issue, the kernel messages scroll way too fast for a
human to be able to read them (let alone vgrep them).

 I'm proposing two features;

 1. a configurable (boot time, via kernel command
line) delay between each and every print -- kind of
overkill, but may be useful sometimes. 
 
 2. a configurable (boot time, via kernel command
line) delay after partition detection, so that a
humble system administrator would be able to actually
find out which partition he should specify at boot
time in order to boot his system.   This is especially
annoying on newer SATA systems where sometimes disks
are detected as SCSI and sometimes as standard ATA
(depending on BIOS settings), I'm sure though that it
could be useful in a number of other cases.

 Let the flames begin

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
