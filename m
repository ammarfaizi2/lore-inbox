Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbTDFMrP (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 08:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262955AbTDFMrP (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 08:47:15 -0400
Received: from mons.uio.no ([129.240.130.14]:5315 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id S262951AbTDFMrL (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 08:47:11 -0400
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5: NFS troubles
References: <1049630768.592.24.camel@teapot.felipe-alfaro.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 06 Apr 2003 14:58:40 +0200
In-Reply-To: <1049630768.592.24.camel@teapot.felipe-alfaro.com>
Message-ID: <shsbrzjn5of.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> writes:

     > Hello, I'm testing 2.5.66-bk11 on my NFS server running
     > RH9. When I run the "find" command on the NFS share from my
     > client computer, it hangs forever after a while, but it always
     > hangs *exactly* at the same place every time. However, if I
     > boot into NFS with RH9's standard kernel (2.4.20), the "find"
     > command works as expected and is able to complete with any
     > hangs or delays.

     > My NFS server (hostname glass) has a whole ext3 partition -
     > mounted under /data - formatted as ext3.

The 2.5.66 ext3 code still has some issues with respect to NFS readdir
cookies.

Cheers,
  Trond
