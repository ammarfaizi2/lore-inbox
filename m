Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264132AbUBKMQK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 07:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264290AbUBKMQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 07:16:10 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:21129 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S264132AbUBKMQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 07:16:09 -0500
Date: Wed, 11 Feb 2004 12:13:50 +0000
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Manfred Spraul <manfred@colorfullife.com>
Subject: userspace mptable parsing broken in 2.6
Message-ID: <20040211121350.GK12634@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Manfred Spraul <manfred@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reading from some parts of /dev/mem is still broken in 2.6.3rc2,
which breaks at least x86info.

Manfred, in the end of the last thread on this at..
http://www.ussg.iu.edu/hypermail/linux/kernel/0311.1/0373.html
you mentioned you were going to add some code to /dev/mem for the
DEBUG_PAGEALLOC case. Did you get anywhere with that?

		Dave

