Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268722AbUJPM7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268722AbUJPM7z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 08:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268719AbUJPM7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 08:59:55 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:64107 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268722AbUJPM7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 08:59:38 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=OFlhKPFE8k1nHsBe9+CqElNaNuMb720g+MpB5eP2lpXDK/W/R1ajPG6ug/cqVo4p4xHgq9VC+k+q8jPGsQhGE9O8jur648XqkuPAoJxqJM1O+OvXgVeEQgAni2/a4VwdYU803h9d7gcgVrqOkQGHGFCmYn25FHmGZanf2Y9RQxI
Message-ID: <82fa6638041016055934097b80@mail.gmail.com>
Date: Sat, 16 Oct 2004 22:59:37 +1000
From: Simon Kissane <skissane@gmail.com>
Reply-To: Simon Kissane <skissane@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Running user processes in kernel mode; Java and .NET support in kernel
In-Reply-To: <82fa66380410152111143f75ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <82fa66380410152111143f75ec@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Having posted the below to this list, Denis Vlasenko pointed out to me
(in an email) that I should have said "user<->kernel" switch, not
context switch. Yep, my mistake. He argues that is not that big. Of
course its no where near as big as a context switch. But its still
something.

Also, I found a website by someone who had this idea before me (and
unlike me, actually implemented it!).
"Kernel Mode Linux" by Toshiyuki Maeda
http://web.yl.is.s.u-tokyo.ac.jp/~tosh/kml/
Main difference is, that rather thinking in terms of Java or Mono
support, he is thinking in terms of another system he calls "Typed
Assembly Language". Same basic idea though...

Cheers
Simon Kissane

On Sat, 16 Oct 2004 14:11:32 +1000, Simon Kissane <skissane@gmail.com> wrote:
> Hi,
> 
> I have some ideas, which I think:
> -       Wouldn't be too hard to implement,
> -       And would give Linux a distinctive advantage over competing
> platforms such as Solaris or Windows, when executing Java or .NET code
[snip]



-- 
Simon Kissane
http://simonkissane.blogspot.com/
