Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262818AbTELWJt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 18:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262855AbTELWJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 18:09:49 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:1690
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262818AbTELWJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 18:09:45 -0400
Subject: Re: The disappearing sys_call_table export.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Valdis.Kletnieks@vt.edu
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200305122212.h4CMCDJ5031682@turing-police.cc.vt.edu>
References: <200305121754_MC3-1-388D-BC60@compuserve.com>
	 <200305122212.h4CMCDJ5031682@turing-police.cc.vt.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052774389.31825.21.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 12 May 2003 22:19:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-05-12 at 23:12, Valdis.Kletnieks@vt.edu wrote:
> >   "That can be done manually" does not get you the check mark in
> > the list of features.  Management wants idiot-resistant security.
> 
> In particular, the code that handles the zeroing out of resource objects
> before re-use needs to be "inside" the trusted-base perimeter.  This has
> been well-understood for years - even my August 83 copy of the Orange Book
> says (for class C2):

1. Base Linux is not C2 certified
2. C2 is obsolete
3. NSA SELinux can do the needed stuff from scanning the code
4. Even then data erasure is not guaranteed because of the drive logic

So you are back to crypting swap in the first place

