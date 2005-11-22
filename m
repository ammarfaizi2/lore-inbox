Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932574AbVKXJOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932574AbVKXJOX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 04:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbVKXJOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 04:14:23 -0500
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:36532 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S932528AbVKXJOV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 04:14:21 -0500
Message-ID: <43833B7A.5020700@rtr.ca>
Date: Tue, 22 Nov 2005 10:38:34 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       IDE/ATA development list <linux-ide@vger.kernel.org>
Subject: 2.6.15-rc2: hundreds of "make sure there is a disc" messages
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When playing a DVD movie (xine), I get hundreds of these
messages from the kernel, flooding my syslogs:

sr0: CDROM not ready.  Make sure there is a disc in the drive.
sr0: CDROM not ready.  Make sure there is a disc in the drive.
sr0: CDROM not ready.  Make sure there is a disc in the drive.
sr0: CDROM not ready.  Make sure there is a disc in the drive.
sr0: CDROM not ready.  Make sure there is a disc in the drive.
sr0: CDROM not ready.  Make sure there is a disc in the drive.
sr0: CDROM not ready.  Make sure there is a disc in the drive.
sr0: CDROM not ready.  Make sure there is a disc in the drive.
sr0: CDROM not ready.  Make sure there is a disc in the drive.

The kernel probably doesn't need to be issuing these,
but rather it should leave it up to the application
to report/log drive conditions like this.

???
