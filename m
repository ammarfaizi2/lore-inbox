Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264841AbTE1TXz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 15:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264843AbTE1TXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 15:23:54 -0400
Received: from verdi.et.tudelft.nl ([130.161.38.158]:64385 "EHLO
	verdi.et.tudelft.nl") by vger.kernel.org with ESMTP id S264841AbTE1TXx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 15:23:53 -0400
Message-Id: <200305281937.h4SJb7og015704@verdi.et.tudelft.nl>
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
X-Exmh-Isig-CompType: repl
X-Exmh-Isig-Folder: inbox
To: Nuno Silva <nuno.silva@vgertech.com>
Cc: linux-kernel@vger.kernel.org, robn@verdi.et.tudelft.nl
Subject: Re: 2.4 bug: fifo-write causes diskwrites to read-only fs ! 
In-Reply-To: Your message of "Wed, 28 May 2003 20:22:04 BST."
             <3ED50C5C.9010309@vgertech.com> 
Mime-Version: 1.0
Content-Type: text/plain
Date: Wed, 28 May 2003 21:37:07 +0200
From: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> Rob van Nieuwkerk wrote:
> > Hi all,
> > 
> > It turns out that Linux is updating inode timestamps of fifos (named
> > pipes) that are written to while residing on a read-only filesystem.
> > It is not only updating in-ram info, but it will issue *physical*
> > writes to the read-only fs on the disk !
> 
> Hi!
> 
> I can't give a solution but the workaround is obvious:
> mount -t ramfs none /myFifos

Hi Nuno,

Yup, already thought of that.
But would be nice if the bug was fixed too !

	greetings,
	Rob van Nieuwkerk
