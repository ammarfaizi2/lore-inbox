Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423030AbWJGAVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423030AbWJGAVd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 20:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423031AbWJGAVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 20:21:33 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:56951 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1423030AbWJGAVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 20:21:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QFTGvdfsbG4PGdM33+Gh2NcjgAu/phJiLJUzKWH9YK0dWpNJbvf9p1arEc5GBYvsOd0m4wX1Ok+WhS+GnUodpVfE/mITWw2zWCNjB8HY+fnOPWlU6ass38bTAEYROjfxX06KZu8IUVMVYIrtbQHPR5l1U5zF3HXp7HomvDa0kZc=
Message-ID: <9a8748490610061721p13f15b80m10f0bbac491cd2a2@mail.gmail.com>
Date: Sat, 7 Oct 2006 02:21:31 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: Simple script that locks up my box with recent kernels
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <9a8748490610061706k7d8228d4s109108bb94f061a8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490610061636r555f1be4x3c53813ceadc9fb2@mail.gmail.com>
	 <20061006165425.23b326e0.akpm@osdl.org>
	 <9a8748490610061706k7d8228d4s109108bb94f061a8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 07/10/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > Once you've got the test set up and running, you can do the alt-ctl-F1
> > thing to take you out of X and into the vga console.  I suggest you leave
> > it running that way, see if anything pops up when it hangs.
> >
> I've done that on a few occasions already without seeing anything, but
> I'll try a few more times.
>

Hmm, trying to do this (with 2.6.19-rc1-git2) seems to have revealed
yet another problem.
If I try to switch to tty1 just after boot, everything is fine. It's
still fine after using the box for a few minutes doing random stuf
like reading email, surfing the web etc, but once my build script has
been running for a few minutes (tested 2 times after ~5min. runs) I
just get a completely white screen when switching to tty1, and when
switching back to X I also just get a white screen :-(
Something is definately broken here....

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
