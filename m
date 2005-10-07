Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbVJGBBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbVJGBBj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 21:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVJGBBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 21:01:39 -0400
Received: from [64.162.99.240] ([64.162.99.240]:41795 "EHLO
	spamtest2.viacore.net") by vger.kernel.org with ESMTP
	id S1751266AbVJGBBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 21:01:38 -0400
Message-ID: <4345C873.3020800@spamtest.viacore.net>
Date: Thu, 06 Oct 2005 17:59:31 -0700
From: Joe Bob Spamtest <joebob@spamtest.viacore.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
References: <20051002204703.GG6290@lkcl.net> <4342DC4D.8090908@perkel.com> <Pine.LNX.4.63.0510051150570.3798@cuia.boston.redhat.com> <4343F815.4000208@perkel.com> <20051005161527.GU7992@ftp.linux.org.uk> <4343FE1C.7090700@perkel.com> <20051005193024.GG8011@csclub.uwaterloo.ca> <20051005224847.GN10538@lkcl.net>
In-Reply-To: <20051005224847.GN10538@lkcl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Luke Kenneth Casson Leighton wrote:
>  the bastion sftp example i gave which required selinux on top of a much
>  broader set of POSIX file permissions demonstrates the fallacy of your
>  statement.
> 
>  try to achieve the same effect with POSIX - even POSIX ACLs
>  (uploader only has create and write, not read, not delete;
>   downloader has read and delete, not write, not create)
> 
>  and you will fail, miserably, because under POSIX, write implies
>  create.

you, however, seem to be missing the point that these are special 
circumstances. in 99% of all cases, regular unix file permissions are 
sufficient. when you start needing special silly permissions for things 
like this, we have special silly tools to accommodate you. Use them. 
Deal with it.

adding a permissions schema similar to that found in windows/netware 
would only unneccessarily complicate things, and most likely end up 
breaking everything.

bottom line: if you want to see support like this in linux, write a 
filesystem with these capabilities built-in. If you don't want to/can't 
write it, then stop complaining and continue to use netware (read: shit 
or get off the pot).
