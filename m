Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266208AbUARBpk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 20:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266213AbUARBpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 20:45:40 -0500
Received: from mail3.absamail.co.za ([196.35.40.69]:41596 "EHLO absamail.co.za")
	by vger.kernel.org with ESMTP id S266208AbUARBpe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 20:45:34 -0500
Subject: [2.6.1 MCE falseness?] Hardware reports non-fatal error
From: Niel Lambrechts <antispam@absamail.co.za>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1074390255.8198.22.camel@ksyrium.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 18 Jan 2004 03:44:16 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I get the following problem with 2.6.1 consistently after apm resuming:

"ksyrium kernel: MCE: The hardware reports a non fatal, correctable
incident occurred on CPU 0.

Message from syslogd@ksyrium at Wed Jan 14 13:33:06 2004 ...
ksyrium kernel: Bank 1: f2000000000001c5"

It does not happen on any other kernels I use (vanilla 2.4.24, SuSE 9
2.4.21-166) - even though CONFIG_X86_MCE=y for both. The equipment is
brand-new - an IBM Thinkpad R50P - and it passes all IBM's s/w
diagnostic.

I'd appreciate help with the parameters for parsemce to interpret the
problem...not sure if my usage is correct? ;)

# ./parsemce -b 1 -a 0 -e f2000000000001c5
Status: (f2000000000001c5) Machine Check in progress.
Restart IP valid.

Is this really hardware (maybe a bug in  the BIOS?) or are false
positives possible with 2.6 MCE code?

-Niel




