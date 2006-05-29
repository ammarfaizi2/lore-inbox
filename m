Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWE2Eht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWE2Eht (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 00:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWE2Eht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 00:37:49 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:5755 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751168AbWE2Ehs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 00:37:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ie5vMAyrWdm4fcoN79AaeXjBMcxQkwCxONdwyGGmGVHtXVwtqx4x3oBqvzxaNoLGBpPyysVwf7PQtP6H+yBUgClwNUsyFdSpZV/GZw6KSfN2AZDoEIlLtKj221y2yHsNmv2xhTmjNNjEwO2tjalpR8Dvgqe9uxt/5/JETS9YHYE=
Message-ID: <9a8748490605282137g24c4eb7awb475318bad7e63b1@mail.gmail.com>
Date: Mon, 29 May 2006 06:37:48 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "=?ISO-8859-1?Q?Haar_J=E1nos?=" <djani22@netcenter.hu>
Subject: Re: How to send a break? - dump from frozen 64bit linux
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01d801c6827c$fba04ca0$1800a8c0@dcccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <01b701c6818d$4bcd37b0$1800a8c0@dcccs>
	 <20060527234350.GA13881@voodoo.jdc.home>
	 <004501c68225$00add170$1800a8c0@dcccs>
	 <9a8748490605280917l73f5751cmf40674fc22726c43@mail.gmail.com>
	 <01d801c6827c$fba04ca0$1800a8c0@dcccs>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/06, Haar János <djani22@netcenter.hu> wrote:
[snip]
> I can only use swap _file_ in this config, and swapping into file is
> relatively slow.

Not so. With a 2.4.x kernel swap files were slower than swap
partitions, but with the 2.6 kernel a swap file is just as fast as a
swap partition.


[snip]
> >
> > 2) You should try the latest stable kernel. Currently that's 2.6.16.18
> > (http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.16.18.tar.bz2).
> > There have been lots of fixes added since 2.6.15.x and perhaps you are
> > lucky that whatever is giving you trouble  has already been fixed in
> > that kernel.
>
> Hmm.
> Last time, when i try the 2.6.16.x, i have lost close to 4000 users home,
> and documents on XFS filesystem!
> (a lot of directory have renamed to "/*" like this one: "/ost+found" in the
> root.)
> I don't want to try it again! :-)
>

That sounds like a pretty serious bug.
Are you sure it was caused by the kernel?
Did you report the bug to LKML & the XFS maintainers so it can get fixed?


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
