Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278879AbRKOKnG>; Thu, 15 Nov 2001 05:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280815AbRKOKmq>; Thu, 15 Nov 2001 05:42:46 -0500
Received: from ns.suse.de ([213.95.15.193]:11270 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S278959AbRKOKmp>;
	Thu, 15 Nov 2001 05:42:45 -0500
Mail-Copies-To: never
To: "Alex Adriaanse" <alex_a@caltech.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: LFS stopped working
In-Reply-To: <JIEIIHMANOCFHDAAHBHOMEONCMAA.alex_a@caltech.edu>
From: Andreas Jaeger <aj@suse.de>
Date: Thu, 15 Nov 2001 11:42:42 +0100
In-Reply-To: <JIEIIHMANOCFHDAAHBHOMEONCMAA.alex_a@caltech.edu> ("Alex
 Adriaanse"'s message of "Thu, 15 Nov 2001 02:03:52 -0800")
Message-ID: <howv0s48nx.fsf@gee.suse.de>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Alex Adriaanse" <alex_a@caltech.edu> writes:

> But ulimit shows that the file size is unlimited... would this be a bug?  If
> that's the case, then how/why would it work before?

If you use an older distro, bash will not handle the changed getrlimit
syscall in 2.4, for details check the Red Hat entry under:
http://www.suse.de/~aj/linux_lfs.html

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
