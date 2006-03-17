Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030248AbWCQSMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbWCQSMl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 13:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbWCQSMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 13:12:41 -0500
Received: from pproxy.gmail.com ([64.233.166.180]:6227 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030249AbWCQSMk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 13:12:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QHVTMYRXXL+ixihp9qVJqWRxAVXBK0suuGTiTnyJ63a3EFgFKWL5knYo81NzoY8dtMgg91/BuMkQ+wl1f4pT9f4GYaaHu12rRXdeOfXOnpJUPIC9aSSqaplEijdN4crtO57DDXCdFYU3pAV8aRINu7oW8GspH0VS1b3Q4mwKqe0=
Message-ID: <bda6d13a0603171012te97c31ew10df997df447a631@mail.gmail.com>
Date: Fri, 17 Mar 2006 10:12:39 -0800
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: chmod 111
In-Reply-To: <200603171746.18894.nick@linicks.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603171746.18894.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/06, Nick Warne <nick@linicks.net> wrote:
> Hi All,
>
> First, I apologise if this isn't a kernel question, but I think it is related.
>
> Slackware 10 base, 2.6.15.6
>
> I am normal user, in groups users and wheel.  Why can I do this:
>
>
> nick@linuxamd:nick$ which ls
> /usr/bin/ls
> nick@linuxamd:nick$ ls -lsa /usr/bin/ls
> 0 lrwxrwxrwx  1 root root 12 2004-07-22 22:52 /usr/bin/ls -> ../../bin/ls
> nick@linuxamd:nick$ cd /bin
> nick@linuxamd:bin$ sudo chmod 111 ls
> nick@linuxamd:bin$ ls -lsa ls
> 76 ---x--x--x  1 root bin 72608 2004-03-16 02:08 ls
>
>
>
> I shouldn't be able to execute 'ls' as I can't read it, shouldn't it?
>
> Nick

You have x permission, you can execute. That's the rules.
Now a shell script, ...
