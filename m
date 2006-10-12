Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422673AbWJLBqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422673AbWJLBqE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 21:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422681AbWJLBqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 21:46:03 -0400
Received: from sycorax.lbl.gov ([128.3.5.196]:1808 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id S1422673AbWJLBqB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 21:46:01 -0400
From: Alex Romosan <romosan@sycorax.lbl.gov>
To: linux-kernel@vger.kernel.org
Subject: 2.6.19-rc1 regression: unable to read dvd's
Date: Wed, 11 Oct 2006 18:45:59 -0700
Message-ID: <87hcya8fxk.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i am not able to read movie dvd's anymore under 2.6.19-rc1. i get the
following in the syslog:

  kernel: hdc: read_intr: Drive wants to transfer data the wrong way!

the drive in question is on a thinkpad t40:

  kernel: hdc: UJDA745 DVD/CDRW, ATAPI CD/DVD-ROM drive
  kernel: hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)

i can read the disks under 2.6.18 so it's probably not the drive's
fault. any ideas?

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
