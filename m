Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbUK1OZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbUK1OZr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 09:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbUK1OZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 09:25:47 -0500
Received: from ptb-relay03.plus.net ([212.159.14.214]:39439 "EHLO
	ptb-relay03.plus.net") by vger.kernel.org with ESMTP
	id S261481AbUK1OZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 09:25:43 -0500
Date: Sun, 28 Nov 2004 14:28:41 +0000
From: Robert Murray <rob@mur.org.uk>
To: linux-kernel@vger.kernel.org
Subject: raid1 oops in 2.6.9 (debian package 2.6.9-1-686-smp)
Message-ID: <20041128142840.GA4119@mur.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

The complete console log can be found at http://haylott.plus.com/~robbie/md-oops.txt

hde is a failed drive. In this log, hdg (the other drive in the raid1
array) is not present. This oops also occurs when hdg is present. I
don't know why it tries to use hde when it has been failed for some
time now.  This doesn't occur with 2.6.8 (also a debian kernel). I
don't have a log of the oops when hdg was present, but I can provide
one if necessary.

Please let me know if there is any other information I can provide to
help to debug this.  For now I have removed hde and everything is
working fine.

Best regards

Rob

