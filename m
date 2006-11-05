Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932618AbWKEKJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932618AbWKEKJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 05:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932619AbWKEKJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 05:09:28 -0500
Received: from [195.171.73.133] ([195.171.73.133]:57026 "EHLO
	pelagius.h-e-r-e-s-y.com") by vger.kernel.org with ESMTP
	id S932618AbWKEKJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 05:09:28 -0500
Date: Sun, 5 Nov 2006 10:09:26 +0000
From: andrew@walrond.org
To: linux-kernel@vger.kernel.org
Subject: Scsi cdrom naming confusion; sr or scd?
Message-ID: <20061105100926.GA2883@pelagius.h-e-r-e-s-y.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/devices.txt says:

 "The prefix /dev/sr (instead of /dev/scd) has been deprecated"

but booting 2.6.18.2 from a scsi CD only works if I pass the kernel
parameter root=/dev/sr0 and fails with root=/dev/scd0

I guess the kernel ought to be taught about the scd* names aswell?

Andrew Walrond
