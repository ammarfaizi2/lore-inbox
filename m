Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132862AbRDXQ5J>; Tue, 24 Apr 2001 12:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135535AbRDXQ4v>; Tue, 24 Apr 2001 12:56:51 -0400
Received: from theseus.mathematik.uni-ulm.de ([134.60.166.2]:5610 "HELO
	theseus.mathematik.uni-ulm.de") by vger.kernel.org with SMTP
	id <S132862AbRDXQ4e>; Tue, 24 Apr 2001 12:56:34 -0400
Message-ID: <20010424165632.3728.qmail@theseus.mathematik.uni-ulm.de>
From: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Date: Tue, 24 Apr 2001 18:56:32 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: BUG: Global FPU corruption in 2.2
In-Reply-To: <cpx7l0g3mfk.fsf@goat.cs.wisc.edu> <20010423161148.6465.qmail@theseus.mathematik.uni-ulm.de> <9c48gv$fbk$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <9c48gv$fbk$1@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Apr 24, 2001 at 09:10:07AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2001 at 09:10:07AM -0700, Linus Torvalds wrote:
> ptrace only operates on processes that are stopped. So there are no
> locking issues - we've synchronized on a much higher level than a
> spinlock or semaphore.

This is only true for requests other than PTRACE_ATTACH and
PTRACE_ATTACH is exactly what I'm worried about.

   regards   Christian

-- 
THAT'S ALL FOLKS!
