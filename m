Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289600AbSAWGzs>; Wed, 23 Jan 2002 01:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289702AbSAWGzj>; Wed, 23 Jan 2002 01:55:39 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:46004 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S289600AbSAWGzc>; Wed, 23 Jan 2002 01:55:32 -0500
Date: Wed, 23 Jan 2002 01:55:31 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: linux-aio@kvack.org
Cc: linux-kernel@vger.kernel.org
Subject: aio-0.3.7
Message-ID: <20020123015531.A30901@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

What can be called aio-0.3.7 is now released.  It consists of 
libaio-0.3.7.tar plus the aio-20020123 patchset (provided for both 
rh-2.4.9 and 2.4.18-pre3).   Note that the 2.4.18-pre3 patchset 
is completely untested, but it looked right and I seem to do okay 
at merging patches usually...  Bug reports and comments welcome.

Download from:

	http://www.kernel.org/pub/linux/kernel/people/bcrl/aio/
	http://people.redhat.com/bcrl/aio/
	http://www.kvack.org/~blah/aio/

RPMS (for RH 7.2):
	http://people.redhat.com/bcrl/aio/dev-3.2-9.tar.gz
	http://people.redhat.com/bcrl/aio/libaio-0.3.7-1.tar.gz
	http://people.redhat.com/bcrl/aio/initscripts-6.42-1.tar

Recent Changes:
	- aio core memory leak fixed
	- aio poll improvements from Suparna added: should be even 
	  faster and more efficient
	- some limits on the size of the completion ring were relaxed
	- now uses dynamic syscalls.  libaio is provided to link 
	  against the 
	- lots of other bugfixes.
-- 
Fish.
