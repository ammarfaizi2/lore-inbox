Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262960AbUEPEqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbUEPEqs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 00:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbUEPEqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 00:46:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:40913 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262960AbUEPEqr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 00:46:47 -0400
Date: Sat, 15 May 2004 21:46:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andreas Amann <amann@physik.tu-berlin.de>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6 breaks kmail (nfs related?)
In-Reply-To: <200405131411.52336.amann@physik.tu-berlin.de>
Message-ID: <Pine.LNX.4.58.0405152142400.25502@ppc970.osdl.org>
References: <200405131411.52336.amann@physik.tu-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 May 2004, Andreas Amann wrote:
> 
> I upgraded from vanilla 2.6.4 to vanilla 2.6.6, using the same compiler 
> (gcc-3.3.1) and .config file (shortened version in attachment) for both. Now 
> I cannot send messages with kmail and  I get the following error messages:
> 
> ...
> kmail: Error: Could not add message to folder (No space left on device?)
> kmail: WARNING: KMail encountered a fatal error and will terminate now.
> The error was:
> KMFolderMaildir::addMsg: abnormally terminating to prevent data loss.

Can you strace it to see what the failing system call was? Especially if 
you can compare the traces between 2.6.4 and 2.6.6 some way..

Trond, any idea? 

		Linus
