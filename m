Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbWE1UkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbWE1UkJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 16:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbWE1UkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 16:40:09 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:13842 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750912AbWE1UkI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 16:40:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ur0CNuJ/RX6kwwA9+0V23FXUNkQKxNQjTWI641/Zvov79CkxtDnEOeVB0AUbZ6qGADQFz8dG0N888pQpjrRwqNxv+eDbCMdIrX9m8yX0NVabiXMI8IG0gU2CiA8PqvzMSRfNbq4CBXJLniZCGYTqoqgUrtfOVbmG/63GrBe0ZQI=
Message-ID: <9a8748490605281340p1f768307l2d5e22a2cfe6e8a7@mail.gmail.com>
Date: Sun, 28 May 2006 22:40:07 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: How to check if kernel sources are installed on a system?
Cc: "Lee Revell" <rlrevell@joe-job.com>,
       "Heiko Carstens" <heiko.carstens@de.ibm.com>,
       devmazumdar <dev@opensound.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1148839964.3074.52.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <e55715+usls@eGroups.com> <1148596163.31038.30.camel@mindpipe>
	 <1148653797.3579.18.camel@laptopd505.fenrus.org>
	 <20060528130320.GA10385@osiris.ibm.com>
	 <1148835799.3074.41.camel@laptopd505.fenrus.org>
	 <1148838738.21094.65.camel@mindpipe>
	 <1148839964.3074.52.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/06, Arjan van de Ven <arjan@infradead.org> wrote:
>
> /boot/config-`uname -r` goes a long way, and yes I'm ignoring the "but
> users CAN clobber the file if they use enough violence against their
> packaging system" argument entirely. That's just a bogus one.
>
You are also ignoring the fact that not all distros store configs
there (and/or under that name).


> Also... why would there really be a need for such a way? Not for
> building anything for sure.... it's for the human. And the human seems
> to just find it already (and again the boot file works well in practice
> it seems)
>

My personal favorite is /proc/config.gz . It has the very nice
property that even if I misplace my config file (or rebuild my tree
several times with different configs and don't save the one for my
running kernel) then I can always get the config for any of the
kernels I have installed, simply by booting it (or extracting it from
the kernel image).

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
