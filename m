Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbTEMBr4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 21:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263132AbTEMBr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 21:47:56 -0400
Received: from siaab1ab.compuserve.com ([149.174.40.2]:24543 "EHLO
	siaab1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S263131AbTEMBrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 21:47:53 -0400
Date: Mon, 12 May 2003 21:57:30 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: The disappearing sys_call_table export.
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <200305122200_MC3-1-3890-B10B@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> 1. Base Linux is not C2 certified

  That could be fixed... (right?)  Filesystems returning data past the
end of what the user wrote might be a big problem though -- this must
be guaranteed even in obscure corner cases.

> 2. C2 is obsolete

  Obsolete or not, it is mandatory for some people.  No check box,
no purchase order (or no certificate of operation.)

> 3. NSA SELinux can do the needed stuff from scanning the code

  But will it get merged?

> 4. Even then data erasure is not guaranteed because of the drive logic

  People who really care require the drive be reduced to pieces small
enough to fit through a sieve with ~2mm holes in it before it leaves
their sight.  For the rest, overwrite of the swap data is a useful if
not 100% reliable step to take.  Legitimate users with servers locked
up in secure areas don't really worry about someone unplugging the box
and walking away with it either.


