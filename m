Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132697AbRDKUIb>; Wed, 11 Apr 2001 16:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132973AbRDKUIY>; Wed, 11 Apr 2001 16:08:24 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:33581 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132978AbRDKUIF>; Wed, 11 Apr 2001 16:08:05 -0400
Date: Wed, 11 Apr 2001 22:12:36 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hubertus Franke <frankeh@us.ibm.com>
Cc: mingo@elte.hu, Linux Kernel List <linux-kernel@vger.kernel.org>,
        lse-tech@lists.sourceforge.net
Subject: Re: Bug in sys_sched_yield
Message-ID: <20010411221236.D30027@athlon.random>
In-Reply-To: <OFC3243AAE.31877E4B-ON85256A2B.006AE9C3@pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFC3243AAE.31877E4B-ON85256A2B.006AE9C3@pok.ibm.com>; from frankeh@us.ibm.com on Wed, Apr 11, 2001 at 03:31:37PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2001 at 03:31:37PM -0400, Hubertus Franke wrote:
> Below is the fix.

correct. Could you also use cpu_curr(cpu) instead of the longer expression?
(for the mainline it's only a beauty issue of course)

Andrea
