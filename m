Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266222AbUHBCnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266222AbUHBCnh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 22:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266220AbUHBCnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 22:43:35 -0400
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:32493 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S266222AbUHBCna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 22:43:30 -0400
X-OB-Received: from unknown (205.158.62.81)
  by wfilter.us4.outblaze.com; 2 Aug 2004 02:40:58 -0000
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: crontraconstantium@mad.scientist.com
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Aug 2004 21:43:18 -0500
Subject: cross between MISC and ELF executables
X-Originating-Ip: 69.37.140.235
X-Originating-Server: ws1-2.us4.outblaze.com
Message-Id: <20040802024318.550651F50B2@ws1-2.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had an idea for a type of executable that is platform independant, but not interpretted or run on top of another OS in a VM, but run in an `inegrated' VM as the OS.

I think this could be done by designing a pseudo-architecture that is very simple and only has the processor functions necessary for a userspace program (std{in,out,err} and access to userspace libraries using the / based fs), not all the fancy direct graphic access stuff on x86 and ppc, or the math of the sparcs.

This would work (in theory) like Java(tm), but free and OS-dependant (and therefore fewer abstraction levels).

If this were to be integrated into the kernel (and glibc and gcc), it might help aleviate some of the problems with proprietary drivers and codecs (nvidia and realmedia come to mind) not being portable. It could also help people porting linux to other architectures because they could port the kernel, and use the cross-platform versions of glibc, login, passwd, shadow, bash, gcc, etc. and worry about porting other things once gcc and the kernel are stable or beta for that architecture.
-- 
___________________________________________________________
Sign-up for Ads Free at Mail.com
http://promo.mail.com/adsfreejump.htm

