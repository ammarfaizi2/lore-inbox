Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbVGERrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbVGERrT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 13:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbVGERrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 13:47:18 -0400
Received: from 39.3.78.83.cust.bluewin.ch ([83.78.3.39]:24883 "EHLO
	kestrel.twibright.com") by vger.kernel.org with ESMTP
	id S261904AbVGERpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 13:45:05 -0400
Date: Tue, 5 Jul 2005 19:16:00 +0200
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: man sendto ENOBUFS desc. wrong
Message-ID: <20050705171600.GA18778@kestrel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Orientation: Gay
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

man send(2):

"       ENOBUFS
	      The output queue for a network interface was full.  This
gener- ally  indicates  that the interface has stopped sending, but may
be caused by transient congestion.   (Normally,  this does  not occur
                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
in Linux. Packets are just silently dropped when a device queue
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
overflows.)"
^^^^^^^^^^

Which is not true, because just happened to me with kernel Linux version
2.6.11-gentoo-r9.

Where should I report?

CL<
