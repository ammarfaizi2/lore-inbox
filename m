Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279470AbRKMVfZ>; Tue, 13 Nov 2001 16:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279462AbRKMVfQ>; Tue, 13 Nov 2001 16:35:16 -0500
Received: from ppp01.ts1-1.NewportNews.visi.net ([209.8.196.1]:52977 "EHLO
	blimpo.internal.net") by vger.kernel.org with ESMTP
	id <S279412AbRKMVfA>; Tue, 13 Nov 2001 16:35:00 -0500
Date: Tue, 13 Nov 2001 16:34:43 -0500
From: Ben Collins <bcollins@debian.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Differences between 2.2.x and 2.4.x initrd
Message-ID: <20011113163443.I329@visi.net>
In-Reply-To: <20011113150317.G329@visi.net> <E163kVM-0005Rf-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E163kVM-0005Rf-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2001 at 07:50:00AM +1100, Herbert Xu wrote:
> Ben Collins <bcollins@debian.org> wrote:
> 
> > Well, the point being that 2.2.x worked implicitly, and 2.4.x doesn't. I
> > don't want to have to tell people who have been using tilo forever and a
> > day that they now have to add additional command line to get it to work
> > with 2.4.x.
> 
> You don't have to.  Just setup linuxrc to echo the right stuff into
> /proc/sys/kernel/real-root-dev

Yeah, which is listed under the "Obsolete" section in
Documentation/initrd.txt. The assumption I'm making here is that if
/linuxrc fails to execute, it falls back to /sbin/init on the currently
mounted root filesystem. Assumptions are bad, but I don't see why it
can't work like this. If there is a filesystem already mounted, it
should be used.



Ben

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/                   Ben Collins    --    Debian GNU/Linux                  \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
