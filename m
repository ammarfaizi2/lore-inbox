Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751747AbWIHAKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbWIHAKc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 20:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751921AbWIHAKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 20:10:31 -0400
Received: from main.gmane.org ([80.91.229.2]:63178 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751747AbWIHAKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 20:10:31 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: David Abrahams <dave@boost-consulting.com>
Subject: prepatching errors
Date: Thu, 07 Sep 2006 20:01:52 -0400
Message-ID: <87k64fz0nj.fsf@pereiro.peloton>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 216-15-125-177.c3-0.smr-ubr3.sbo-smr.ma.cable.rcn.com
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.0 (gnu/linux)
Cancel-Lock: sha1:NuYcyizI/cO6B5JKcm2ri7WCz+A=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm trying to apply the 2.6.18-rc6 prepatch (from
http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.18-rc6.bz2)
to the 2.6.17.11 sources (from
http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.17.11.tar.bz2) using

  patch -p1 < ~/patch-2.6.18-rc6

and I'm seeing various error messages, e.g.:

  patching file Makefile
  Hunk #1 FAILED at 1.
  1 out of 39 hunks FAILED -- saving rejects to file Makefile.rej

  ...

  patching file arch/um/kernel/time_kern.c
  Reversed (or previously applied) patch detected!  Assume -R? [n] 
  Apply anyway? [n] 
  Skipping patch.
  1 out of 1 hunk ignored -- saving rejects to file arch/um/kernel/time_kern.c.rej

Am I doing something wrong?  Is this normal?

I'm downloading the 2.6.17.11 tarball again just in case I've confused
something, but I've been untaring the raw material from a file I have
called linux-2.6.17.11.tar.bz2, so it seems unlikely.

Any advice appreciated!

Thanks,

-- 
Dave Abrahams
Boost Consulting
www.boost-consulting.com

