Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268235AbUIGRJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268235AbUIGRJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 13:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268322AbUIGQ5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 12:57:50 -0400
Received: from mx02.qsc.de ([213.148.130.14]:16769 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S268190AbUIGQzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 12:55:48 -0400
Date: Tue, 07 Sep 2004 18:55:26 +0200
From: Gunnar Ritter <Gunnar.Ritter@pluto.uni-freiburg.de>
Organization: Privat.
To: Spam <spam@tnonline.net>
Cc: ReiserFS List <reiserfs-list@namesys.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: silent semantic changes with reiser4
Message-ID: <413DE7FE.nailD9I11PGNI@pluto.uni-freiburg.de>
References: <200409070206.i8726vrG006493@localhost.localdomain>
 <413D4C18.6090501@slaphack.com> <m3d60yjnt7.fsf@zoo.weinigel.se>
 <1183150024.20040907143346@tnonline.net>
 <413DD5B4.nailC801GI4E2@pluto.uni-freiburg.de>
 <1401724342.20040907182551@tnonline.net>
In-Reply-To: <1401724342.20040907182551@tnonline.net>
User-Agent: nail 11.6 9/7/04
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spam <spam@tnonline.net> wrote:

> > Spam <spam@tnonline.net> wrote:
> >>   One suggestion is missed. It is to provide system calls for copy.
> >>   That would also solve the problem.
> > No, it would not. If you read the POSIX.1 specification for cp
> > carefully <http://www.unix.org/version3/online.html>, you will
> > notice that the process for copying a regular file is carefully
> > standardized. A POSIX.1-conforming cp implementation would not
> > be allowed to copy additional streams, unless either additional
> > options are given or the type of the file being copied is other
> > than S_IFREG. And cp is just one example of a standardized file
> > handling program.
>   It would solve the problem in Linux. However, it may not be POSIX.1
>   compatible. On the other hand I read that NTFS 5.0 is POSIX.1
>   compliant - and Windows uses copy system call.

You should obviously take a thorough read of at least the Base
Definitions, section 2, 'Conformance' of POSIX.1 before you further
comment on this issue.

	Gunnar
