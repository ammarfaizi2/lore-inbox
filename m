Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262692AbTDFTpG (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 15:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263058AbTDFTpG (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 15:45:06 -0400
Received: from Mail1.KONTENT.De ([81.88.34.36]:13977 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262692AbTDFTpF (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 15:45:05 -0400
From: Oliver Neukum <oliver@neukum.org>
Reply-To: oliver@neukum.name
To: Dan Kegel <dank@kegel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH] new syscall: flink
Date: Sun, 6 Apr 2003 21:56:37 +0200
User-Agent: KMail/1.5
References: <3E907A94.9000305@kegel.com>
In-Reply-To: <3E907A94.9000305@kegel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304062156.37325.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Andrew Brown <atatat@atatdot.net> wrote:
>  ># as for flink(2), no.  flink(2) would be a terribly bad idea.  consider
>  ># that when opening a file, *all* the permissions on *all* the inodes in
>  ># the path to the file are considered.  if you were able to get some
>  ># process to hand you an open file descriptor to some file somewhere
>  ># that relies on being protected by permissions in the path and you were
>  ># able to flink(2) it to some arbitrary name, you could bypass the
>  ># permissions set that had been established.

If you have an fd, the permissions based on the path are already
bypassed, whether you can call flink or not, aren't they?

	Regards
		Oliver

