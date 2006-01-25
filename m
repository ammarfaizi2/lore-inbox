Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWAYXC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWAYXC7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 18:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbWAYXC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 18:02:59 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:39903 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932206AbWAYXC6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 18:02:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tWx2ssuFIuP2HjmgvBzG5y4zzUkSFSBXG6BoUhl+xF60fwbdZOEHrfqi1dZEV9VV+jJkA2gUzW1pPG0iHvn8hp7AL+E1D4Rr9+WJr0St+T8ofEGMJgYK6Z29FfOgs9PJEqIqZYoGbOKyW1RyiuBPK2mswIWYi+PZGR2OewtacHE=
Message-ID: <9a8748490601251502q7d0ed605xb2b6477ffe5ea87f@mail.gmail.com>
Date: Thu, 26 Jan 2006 00:02:56 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: jerome lacoste <jerome.lacoste@gmail.com>
Subject: Re: [RFC] make it easy to test new kernels
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <5a2cf1f60601251430k5823e7dald12c9b5f8bc297be@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a2cf1f60601251430k5823e7dald12c9b5f8bc297be@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/06, jerome lacoste <jerome.lacoste@gmail.com> wrote:
[...]
>
> Now, will all these talks about virtualization, I wonder if it will be
> possible one day to just download a new virtualized test OS and test
> it without rebooting the main one. I could always allocate 10 G to a
> test system on my disk. As long as I don't have to reboot.
>
[...]

Sure, you can test some aspects of the kernel in a virtualized environment.
Setup Xen [1] or UML [2] (or some other virtual machine software like
Bochs [3] or Qemu [4]) and use those virtual environments for testing
your new kernels - no reboots required.
Not the best way to test all aspects of new kernels, but if reboots
are out of the question then they are certainly options and better
than no testing at all :)


1. http://www.cl.cam.ac.uk/Research/SRG/netos/xen/
2. http://user-mode-linux.sourceforge.net/
3. http://bochs.sourceforge.net/
4. http://fabrice.bellard.free.fr/qemu/


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
