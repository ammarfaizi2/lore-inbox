Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbWAHFW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWAHFW5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 00:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWAHFW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 00:22:57 -0500
Received: from pxy2nd.nifty.com ([202.248.175.14]:48529 "HELO pxy2nd.nifty.com")
	by vger.kernel.org with SMTP id S1751098AbWAHFW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 00:22:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=pxy2nd-default; d=nifty.com;
  b=0HBhmHju1HDEj86KzIaVXgf7BzPPjMocCHA0MZzTQtosShYf4gKdtS+RtL39BMONWdGBxj8zliyirvk1c8FyEQ==  ;
Message-ID: <5313771.1136697761289.komurojun-mbn@nifty.com>
Date: Sun, 8 Jan 2006 14:22:41 +0900 (JST)
From: Komuro <komurojun-mbn@nifty.com>
To: Junio C Hamano <junkio@cox.net>
Subject: Re: Re: [KERNEL 2.6.15]  All files have -rw-rw-rw- permission.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7vmzi78vlh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: @nifty Webmail 2.0
References: <7vmzi78vlh.fsf@assigned-by-dhcp.cox.net>
 <20060105191736.1ac95e4b.rdunlap@xenotime.net>
	<1986219.1136463311449.komurojun-mbn@nifty.com>
	<3378320.1136549095236.komurojun-mbn@nifty.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

>> But, is there any reason to set -----w--w- bit
>> by default?
>
>Yes.
>
>Please do not extract the kernel tarball as the root user,
>especially if you do not know how tar command works for root
>user by default (hint: --no-same-permissions).
>
>Setting g-w in the archive forces arbitrary policy on people who
>work with umask 002 as a non-root user.  We can let that policy
>to be controlled by user's umask by being lenient in the
>tarball.  For the same reason, if somebody has umask 0, there is
>no reason for us (as tarball creator) to impose o-w as a policy
>on him either, hence git-tar-tree output has 0666 or 0777 modes.
>

O.K.

Thanks,
Komuro


