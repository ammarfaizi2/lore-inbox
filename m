Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267749AbUIGQ3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267749AbUIGQ3J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 12:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268177AbUIGQ3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 12:29:07 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:1955 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S267749AbUIGQ0E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 12:26:04 -0400
Date: Tue, 7 Sep 2004 18:25:51 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <1401724342.20040907182551@tnonline.net>
To: Gunnar Ritter <Gunnar.Ritter@pluto.uni-freiburg.de>
CC: ReiserFS List <reiserfs-list@namesys.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <413DD5B4.nailC801GI4E2@pluto.uni-freiburg.de>
References: <200409070206.i8726vrG006493@localhost.localdomain>
 <413D4C18.6090501@slaphack.com> <m3d60yjnt7.fsf@zoo.weinigel.se>
 <1183150024.20040907143346@tnonline.net>
 <413DD5B4.nailC801GI4E2@pluto.uni-freiburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  

> Spam <spam@tnonline.net> wrote:

>>   One suggestion is missed. It is to provide system calls for copy.
>>   That would also solve the problem.

> No, it would not. If you read the POSIX.1 specification for cp
> carefully <http://www.unix.org/version3/online.html>, you will
> notice that the process for copying a regular file is carefully
> standardized. A POSIX.1-conforming cp implementation would not
> be allowed to copy additional streams, unless either additional
> options are given or the type of the file being copied is other
> than S_IFREG. And cp is just one example of a standardized file
> handling program.

  It would solve the problem in Linux. However, it may not be POSIX.1
  compatible. On the other hand I read that NTFS 5.0 is POSIX.1
  compliant - and Windows uses copy system call. NTFS also has streams
  support using special character in the file names to select the
  streams.

  Surely there must be a solution in Linux that will allow things like
  streams and meta-data(meta-streams) be visible to the user.
  ~S

> 	Gunnar


