Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262052AbUECVoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbUECVoQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 17:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264039AbUECVoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 17:44:16 -0400
Received: from topper.inf.ed.ac.uk ([129.215.32.40]:37575 "EHLO
	topper.inf.ed.ac.uk") by vger.kernel.org with ESMTP id S262052AbUECVoI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 17:44:08 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16534.48421.296794.467014@toolo.inf.ed.ac.uk>
Date: Mon, 3 May 2004 22:44:05 +0100
From: Julian Bradfield <jcb@inf.ed.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: hang with 2.4.26 copying to loopback device
X-Mailer: VM 7.18 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running a vanilla 2.4.26 kernel (on a rather old distro, Mandrake
9.0).
I have large (6GB) file on a remote NFS server (running 2.4.18), on
which
there is a file system that I'm mounting via loopback.
When I copy to this looped back filesystem, I get a hang after a few
megabytes. After the copy hangs, I move the cursor around and soon X
freezes as well. I can, however, reboot via sysrq.

I've seen several reports a couple of years ago of deadlocks in
loopback, but nothing recently that I can find via searching.
Is there anything currently known to be an issue, or should I start
preparing a proper report?
