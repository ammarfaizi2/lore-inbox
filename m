Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbUJWUW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbUJWUW4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 16:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbUJWUWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 16:22:30 -0400
Received: from melos.informatik.uni-rostock.de ([139.30.241.22]:38917 "EHLO
	melos.informatik.uni-rostock.de") by vger.kernel.org with ESMTP
	id S261301AbUJWUSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 16:18:35 -0400
From: Denny Priebe <dpr@siglost.org>
Date: Sat, 23 Oct 2004 22:10:50 +0200
To: linux-kernel@vger.kernel.org
Subject: CDROMEJECT using ide-scsi not working since 2.6.9-rc2
Message-ID: <20041023201050.GA4673@nostromo.nofw.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

since 2.6.9-rc2 CDROMEJECT is no longer working when using ide-scsi.
(At least for my Sony DVD RW DW-U55A. I've tried 2.6.8.1, 2.6.9-rc[1234], 
and 2.6.9.)

strace eject /dev/scd0 reports
[...]
open("/dev/scd0", O_RDONLY|O_NONBLOCK)  = 3
ioctl(3, CDROMEJECT, 0xbffffbd8)        = 0
close(3)                                = 0
[...]
but nothing happens.

I know that using ide-scsi is deprecated for cd burning but: is this a 
feature or a bug?

Greetings,
Denny
