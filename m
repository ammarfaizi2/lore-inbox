Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbTFBOtE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 10:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbTFBOtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 10:49:04 -0400
Received: from franka.aracnet.com ([216.99.193.44]:3049 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262371AbTFBOtD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 10:49:03 -0400
Date: Mon, 02 Jun 2003 08:02:22 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 764] New: btime in /proc/stat wobbles (even over 30 seconds)
Message-ID: <205830000.1054566142@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: btime in /proc/stat wobbles (even over 30 seconds)
    Kernel Version: 2.5.70 but also in 2.2.20
            Status: NEW
          Severity: normal
             Owner: johnstul@us.ibm.com
         Submitter: h.lambermont@aramiska.net


Distribution: Debian and Red Hat
Hardware Environment: i386
Software Environment: /proc
Problem Description:

btime in /proc/stat changes over time. We even see it wobble over 30 seconds.
See also
http://www.google.nl/search?q=cache:ISSy3HrMcvQJ:bugzilla.redhat.com/bugzilla/long_list.cgi%3Fbuglist%3D75107+btime+/proc/stat&hl=nl&ie=UTF-8

Steps to reproduce:

Comparing /proc/stat's btime every minute shows the differences.
We see this behaviour on all of our 1500 Linux machines.


