Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288308AbSAQIbq>; Thu, 17 Jan 2002 03:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288325AbSAQIbg>; Thu, 17 Jan 2002 03:31:36 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:25813 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S288308AbSAQIbU>; Thu, 17 Jan 2002 03:31:20 -0500
From: Christoph Rohland <cr@sap.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: pte-highmem-5
In-Reply-To: <20020116185814.I22791@athlon.random>
Organisation: SAP LinuxLab
Date: Thu, 17 Jan 2002 09:31:12 +0100
In-Reply-To: <20020116185814.I22791@athlon.random> (Andrea Arcangeli's
 message of "Wed, 16 Jan 2002 18:58:14 +0100")
Message-ID: <m3u1tll6pb.fsf@linux.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

On Wed, 16 Jan 2002, Andrea Arcangeli wrote:
> They were running out of pagetables, mapping 1G per-task (shm for
> example) will overflow the lowmem zone with PAE with some houndred
> tasks in the system. They were pointing the finger at the VM but the
> VM was just doing the very right thing to do.

This lets me think about putting the swap vector of shmem into highmem
also. These can get big on highend servers and exactly these servers
tend to use a lot of shared mem.

What do you think?

		Christoph


