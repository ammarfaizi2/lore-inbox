Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262308AbVCVBb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbVCVBb6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 20:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbVCVB3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 20:29:15 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:8930 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262271AbVCVB15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:27:57 -0500
Date: Mon, 21 Mar 2005 20:27:26 -0500
From: Dan Maas <dmaas@maasdigital.com>
To: linux-kernel@vger.kernel.org
Subject: Distinguish real vs. virtual CPUs?
Message-ID: <20050321202726.A7630@morpheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-Info: http://www.maasdigital.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a canonical way for user-space software to determine how many
real CPUs are present in a system (as opposed to HyperThreaded or
otherwise virtual CPUs)?

We have an application that for performance reasons wants to run one
process per CPU. However, on a HyperThreaded system /proc/cpuinfo
lists two CPUs, and running two processes in this case is the wrong
thing to do. (Hyperthreading ends up degrading our performance,
perhaps due to cache or bus contention).

Please CC replies.

Thanks,
Dan Maas
