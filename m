Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264701AbUEPR7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264701AbUEPR7t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 13:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbUEPR7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 13:59:49 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:11908 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S264701AbUEPR7r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 13:59:47 -0400
Subject: Re: 2.6.6 breaks kmail (nfs related?)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andreas Amann <amann@physik.tu-berlin.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405152142400.25502@ppc970.osdl.org>
References: <200405131411.52336.amann@physik.tu-berlin.de>
	 <Pine.LNX.4.58.0405152142400.25502@ppc970.osdl.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1084730382.3764.7.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 16 May 2004 13:59:42 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På su , 16/05/2004 klokka 00:46, skreiv Linus Torvalds:

> Can you strace it to see what the failing system call was? Especially if 
> you can compare the traces between 2.6.4 and 2.6.6 some way..
> 
> Trond, any idea? 

Not really: there isn't anything in the NFS filesystem code that can
generate an ENOSPC. I agree that the "strace" output will help.

Andreas are both the server and the client running 2.6.6? If so, which
do you have to downgrade to 2.6.4 in order to get rid of the error?

Cheers,
  Trond
