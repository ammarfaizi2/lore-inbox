Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268792AbRHaSDu>; Fri, 31 Aug 2001 14:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268835AbRHaSDl>; Fri, 31 Aug 2001 14:03:41 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:46340 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S268792AbRHaSDY>;
	Fri, 31 Aug 2001 14:03:24 -0400
Date: Fri, 31 Aug 2001 20:03:33 +0200
From: Jens Axboe <axboe@suse.de>
To: Jonathan Lahr <lahr@us.ibm.com>
Cc: lahr@beaverton.ibm.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: io_request_lock/queue_lock patch
Message-ID: <20010831200333.A9069@suse.de>
In-Reply-To: <20010830134930.F23680@us.ibm.com> <20010831075613.A2855@suse.de> <20010831075201.N23680@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010831075201.N23680@us.ibm.com>; from lahr@us.ibm.com on Fri, Aug 31, 2001 at 07:52:01AM -0700
X-OS: Linux 2.2.20 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31 2001, Jonathan Lahr wrote:
> 
> Jens,
> 
> Please elaborate on "no, no, no".   Are you suggesting that no further
> improvements can be made or should be attempted on the 2.4 i/o subsystem?

Of course not. The no no no just means that attempting to globally remove the
io_request_lock at this point is a no-go, so don't even go there. The
sledgehammer approach will not fly at this point, it's just way too risky.

Jens
