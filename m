Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265329AbTFXAQX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 20:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265418AbTFXAQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 20:16:23 -0400
Received: from air-2.osdl.org ([65.172.181.6]:7112 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265329AbTFXAQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 20:16:17 -0400
Subject: [KEXEC][ANNOUNCE] kexec for 2.5.73 available
From: Andy Pfiffer <andyp@osdl.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>,
       Suparna Bhattacharya <suparna@in.ibm.com>, fastboot@osdl.org
Content-Type: text/plain
Organization: 
Message-Id: <1056414583.1209.23.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 23 Jun 2003 17:29:43 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A patch set for kexec for 2.5.73 is now available. This patch set is
based upon the stable 2.5.{67,68,69,70,71,72} versions.

This patch was tested to work on a dual P4-1.7GHz Xeon system, a
uniprocessor P3-800 system, and a dual P3-866 system. I continue to
observe strangeness with the re-initialization of the VESA framebuffer
(character-based console TTY worked correctly), a kernel oops in the
2.5.72 version on a 4-way while preparing the reboot memory buffer, and
a hang seen when using the serial console (RS232). 

More info here:
http://www.osdl.org/archive/andyp/bloom/Code/Linux/Kexec/index.html

Unified full kexec patch for 2.5.73 is here:
http://www.osdl.org/archive/andyp/kexec/2.5.73/kexec2-2.5.73-full.patch

Source tarball of the matching user-mode utility for kexec 2.5.73:
http://www.osdl.org/archive/andyp/kexec/2.5.73/kexec-tools-1.8-2.5.73.tgz

Unstable 2.5.69 kexec patches from Eric Biederman are available here:
http://www.xmission.com/~ebiederm/files/kexec/

Regards,
Andy


