Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbTILOl3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 10:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbTILOl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 10:41:29 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:11672 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261713AbTILOl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 10:41:27 -0400
Subject: Hyperthreading: easiest userland method?
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFACE20891.664CABA8-ON85256D9F.004FBBDE@torolab.ibm.com>
From: "Dan Behman" <dbehman@ca.ibm.com>
Date: Fri, 12 Sep 2003 10:41:18 -0400
X-MIMETrack: Serialize by Router on D25ML02/25/M/IBM(Release 5.0.9a |January 7, 2002) at
 09/12/2003 10:41:23 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a need to programmatically determine whether or not hyperthreading
is enabled (and in use) for licensing reasons in my application.
Currently, I know of two ways to do this:

1) parse /proc/cpuinfo for "processor id"
2) port Intel's documented method (written for Windows) to directly query
the CPUs

Both methods have drawbacks - 1) relying on specific text that could change
is a bad idea; 2) this doesn't take into account whether or not Linux
and/or the BIOS is making use of the hyperthreading.

>From scouring the archives and the net, it doesn't seem like there's any
API that currently exists, but perhaps I've missed something.
/proc/cpuinfo gathers its information from somewhere - is there a way in
userland to bypass /proc/cpuinfo and directly get this data manually?

I'm interested in both 2.4 and 2.6 implementations and would like to be
personally CC'ed on any repsonses.

Thanks in advance!

Dan Behman.
IBM Canada Ltd.

