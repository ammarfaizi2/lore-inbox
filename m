Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262170AbREQCBR>; Wed, 16 May 2001 22:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262172AbREQCBI>; Wed, 16 May 2001 22:01:08 -0400
Received: from felix.convergence.de ([212.84.236.131]:8614 "EHLO
	convergence.de") by vger.kernel.org with ESMTP id <S262170AbREQCA5>;
	Wed, 16 May 2001 22:00:57 -0400
Date: Thu, 17 May 2001 04:00:00 +0200
From: Felix von Leitner <leitner@convergence.de>
To: linux-kernel@vger.kernel.org
Subject: vfat large file support
Message-ID: <20010517040000.A22911@convergence.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't copy a file larger than 2 gigs to my vfat partition.
What gives?  2.4.4-ac5 kernel.  My cp copies 2 gigs and then aborts.

  $ echo foo >> file_on_vfat_partition

causes the shell to become unresponsive and consume lots of CPU time.

Felix
