Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbTKZAZt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 19:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263765AbTKZAZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 19:25:49 -0500
Received: from pat.uio.no ([129.240.130.16]:8416 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263258AbTKZAZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 19:25:47 -0500
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux 2.4.23-rc4] NFS mounts on top of initrd
References: <Pine.LNX.4.44.0311241656430.8709-100000@logos.cnet>
	<20031124222129.GC1823@werewolf.able.es>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 25 Nov 2003 19:25:42 -0500
In-Reply-To: <20031124222129.GC1823@werewolf.able.es>
Message-ID: <shs65h8vuux.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == J A Magallon <J.A.> writes:

     > close(3) = 0 open("/lib/libnss_files-2.3.2.so", O_RDONLY) = -1
     > ESTALE (Stale NFS file handle) read(-1, 0xbffffc40, 512) = -1
     > EBADF (Bad file descriptor)

Mind sending us a tcpdump too, so that we can work out what the
client/server are actually doing?

tcpdump -w dump.out -s 9000

Cheers,
  Trond
