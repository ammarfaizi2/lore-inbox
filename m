Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132215AbRCVWK3>; Thu, 22 Mar 2001 17:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132216AbRCVWKU>; Thu, 22 Mar 2001 17:10:20 -0500
Received: from mons.uio.no ([129.240.130.14]:24309 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S132215AbRCVWKE>;
	Thu, 22 Mar 2001 17:10:04 -0500
To: Camm Maguire <camm@enhanced.com>
Cc: linux-kernel@vger.kernel.org, nfs-devel@linux.kernel.org
Subject: Re: PROBLEM: 2.2.18 oops leaves umount hung in disk sleep
In-Reply-To: <E14g8eP-0006k5-00@intech19.enhanced.com>
	<shs1yrpabky.fsf@charged.uio.no>
	<54hf0l8ug1.fsf@intech19.enhanced.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 22 Mar 2001 23:09:13 +0100
In-Reply-To: Camm Maguire's message of "22 Mar 2001 14:39:10 -0500"
Message-ID: <shspuf98nhy.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Camm Maguire <camm@enhanced.com> writes:

     > I'd be happy to generate one if I could.  I've got the system
     > map.  The defaults reported by ksymoops are all correct.  Don't
     > know why it didn't give me more info.  Normally, the info is
     > reported by klogd anyway, but not here.  I've sent you all I
     > currently have.  If you can suggest how I can get more, would
     > be glad to do so.


Unless you happen to have a dump from 'dmesg', there's probably not
much you can do to recover the rest of the Oops...

We need at least the line 'EIP:' if we're to find out where the fault
occurred. Are you certain that it can't be found in the syslog?

     > I thought I was running v3.  Can't seem to find anything now
     > which indicates the protocol version in use, but was under the
     > impression that v4 was only an option in 2.4.x, no?


Mar 21 01:14:49 intech9 automount[305]: using kernel protocol version 3 on reawaken

Sorry, the above message fooled me.


Cheers,
  Trond
