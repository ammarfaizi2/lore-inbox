Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268327AbRGWSix>; Mon, 23 Jul 2001 14:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268329AbRGWSin>; Mon, 23 Jul 2001 14:38:43 -0400
Received: from mons.uio.no ([129.240.130.14]:7850 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S268327AbRGWSib>;
	Mon, 23 Jul 2001 14:38:31 -0400
To: Dave Airlie <airlied@skynet.ie>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, <nfs-devel@linux.kernel.org>,
        <nfs@lists.sourceforge.net>
Subject: Re: [NFS] Solaris 2.6 server Linux 2.2.19 client .. stale handle
In-Reply-To: <Pine.LNX.4.32.0107231231380.4567-100000@skynet>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 23 Jul 2001 20:38:31 +0200
In-Reply-To: Dave Airlie's message of "Mon, 23 Jul 2001 12:32:56 +0100 (IST)"
Message-ID: <shslmlfwkwo.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

>>>>> " " == Dave Airlie <airlied@skynet.ie> writes:

     > Hi,
     > 	I'm running Linux 2.2.19 client NFSv3 from a Solaris 2.6
     > 	server,
     > when the server reboots I get stale handles on any mounts from
     > that server...

     > I though this got fixed ages ago... or do I need to patch
     > something on the Solaris side?

No. I just need to do a backport of

  http://www.fys.uio.no/~trondmy/src/2.4.7/linux-2.4.7-stale.dif

Cheers,
  Trond
