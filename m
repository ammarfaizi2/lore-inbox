Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133118AbRAVTli>; Mon, 22 Jan 2001 14:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135220AbRAVTl2>; Mon, 22 Jan 2001 14:41:28 -0500
Received: from egghead.curl.com ([216.230.83.4]:25604 "HELO egghead.curl.com")
	by vger.kernel.org with SMTP id <S133118AbRAVTlS>;
	Mon, 22 Jan 2001 14:41:18 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [NFS] Help: 2.2.18 NFS is corrupting our files
In-Reply-To: <s5gvgr71xao.fsf@egghead.curl.com>
	<shsbsszqus5.fsf@charged.uio.no>
From: patl@curl.com (Patrick J. LoPresti)
Date: 22 Jan 2001 14:41:16 -0500
In-Reply-To: Trond Myklebust's message of "22 Jan 2001 19:57:46 +0100"
Message-ID: <s5g66j7tlwj.fsf@egghead.curl.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> writes:

> What filesystem are you exporting?

Just ext2; all of our file systems are ext2.

The disks here are a mixture of IDE, SCSI (aic7xxx and sym53c8xx), and
Mylex DAC960 RAID.  In this case, the machine running 2.2.18 has
aic7xxx SCSI.  I suspect I could reproduce the problem on other
configurations; let me know if that would be useful.

 - Pat
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
