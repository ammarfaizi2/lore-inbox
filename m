Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWGPTNB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWGPTNB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 15:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWGPTNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 15:13:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:32995 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751163AbWGPTNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 15:13:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=V1W2JA6KkB61RZGxfXsi+weSmavGzHNYjtzpPLQQEVGuWKhS4gpWOKNIW5vNdhw5GS4jbjco8xQracjWP5xddFoFMAofS/3jvJLBhG8Y0acnzCXA34DFaLwFkRLB/u7t/+rxOzi0cAB6i0hQTZjdHRI6DsnxVNl2iDbuKUptVEQ=
Message-ID: <427c54c0607161212m714f4faew60b8615e06ac885a@mail.gmail.com>
Date: Sun, 16 Jul 2006 14:12:58 -0500
From: "Daniel De Graaf" <danieldegraaf@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Rescan IDE interface when no IDE devices are present
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My laptop has only one IDE interface (/dev/hdc), which means there are
no valid IDE block devices which can be used for HDIO_SCAN_HWIF ioctl
to scan for the insertion of my CD-ROM drive.

Are there alternate methods of invoking this ioctl, or for creating an
open filehandle where it can be used?
