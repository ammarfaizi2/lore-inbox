Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263522AbTDTEBe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 00:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263523AbTDTEBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 00:01:34 -0400
Received: from corb.mc.mpls.visi.com ([208.42.156.1]:20660 "EHLO
	corb.mc.mpls.visi.com") by vger.kernel.org with ESMTP
	id S263522AbTDTEBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 00:01:33 -0400
Subject: May be off topic: ioctl I_SETSIG S_INPUT setting not valid for a named
 pipe?
To: linux-kernel@vger.kernel.org
Date: Sat, 19 Apr 2003 23:13:33 -0500 (CDT)
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20030420041333.56A8376CA2@isis.visi.com>
From: jlb@visi.com (Joel L. Breazeale)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a set of programs which practically demonstrate the I_SETSIG ioctl
command does not work with the S_INPUT constant for a named pipe.  The errno
value returned by the ioctl call is 22.  Two kernel versions demonstrating
this problem are 2.4.18-3 and 2.4.20-9.

I have already sent the details of this problem, including the sample
programs, in a message on 14 Apr 2003 with a subject of "PROBLEM: ioctl()
I_SETSIG S_INPUT option fails on a FIFO" to this mailing list.  I would be
glad to send to anyone upon request.

Here are my questions:

  * Is the above ioctl deprecated for named pipes?
  * Who is the maintainer of this functionality (who presonally is
    willing to receive a problem report on this matter)?

[I would greatly appreciate a personal e-mail on this subject as I may be
dropping from this mailing list shortly due to volume and apparently lack
of interest in this subject.]

Thank you,
Joel Breazeale
