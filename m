Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263366AbRFYKUa>; Mon, 25 Jun 2001 06:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263461AbRFYKUU>; Mon, 25 Jun 2001 06:20:20 -0400
Received: from juicer03.bigpond.com ([139.134.6.79]:50430 "EHLO
	mailin6.bigpond.com") by vger.kernel.org with ESMTP
	id <S263366AbRFYKUE>; Mon, 25 Jun 2001 06:20:04 -0400
Message-ID: <3B371035.63563C4B@bigpond.com>
Date: Mon, 25 Jun 2001 20:19:33 +1000
From: Allan Duncan <allan.d@bigpond.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre5 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Rohland <cr@sap.com>
CC: "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@vger.kernel.org
Subject: Re: Shared memory quantity not being reflected by /proc/meminfo
In-Reply-To: <200106240249.f5O2nIF07215@saturn.cs.uml.edu>
		<m3n16yjmkl.fsf@linux.local> <3B35DC3D.6D2DC9C@bigpond.com> <m3els9jb4t.fsf@linux.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Rohland wrote:
> 
> Hi Allan,
> 
> On Sun, 24 Jun 2001, Allan Duncan wrote:
> > OK, it's fine by me if the "shared" under 2.2.x is not the same,
> > however in that case the field should not appear at all in meminfo,
> > rather than the current zero value, which leads lesser kernel
> > hackers like me up the garden path.
 
> This would probably break a lot of user space apps.


Then only break those that do a lousy parsing of meminfo and change the
heading line to "shared_is_not_real:" or somesuch?
Anyway, aren't the user apps being led up the garden path with the wrong
answer?
