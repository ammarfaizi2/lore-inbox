Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbVDRAza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVDRAza (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 20:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVDRAza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 20:55:30 -0400
Received: from web60119.mail.yahoo.com ([209.73.178.87]:2428 "HELO
	web60119.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261378AbVDRAzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 20:55:25 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=FWgeb8s1jnQmUTVRnrASnCpBw5vJiNmQEvQwOTXexvg1R/imFD+ag4KTV52NwDJkWr2Q17NJvU+VWixgpMb74NqG2gokyWQgqKj+r30X5M9cDhYn4Q/72QtaTgzc0M25yVdNsk8x8Z0yPMEUmESyeEQvHBjfMLSs7+8HaRkLvZ4=  ;
Message-ID: <20050418005525.7250.qmail@web60119.mail.yahoo.com>
Date: Sun, 17 Apr 2005 17:55:25 -0700 (PDT)
From: S S <singsys@yahoo.com>
Subject: Kernelpanic - not syncing: VFS: Unable to mount root fs on unknown-block
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I compiled linux kernel 2.6.11.7 on RHEL and while
rebooting I get this
error message -

Cannot open root device /SCSIGroup00/SCSIVol000
Please append a correct "root=" boot option
Kernelpanic - not syncing: VFS: Unable to mount root
fs on
unknown-block 0,0

This root entry in grub .conf is identical to kernel
image entry 2.6.9 which boots fine. However 2.6.11.7
compiled kernel does not find
/dev//SCSIGroup00/SCSIVol000

Could anyone please suggest what could be going wrong.

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
