Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316039AbSFCNTS>; Mon, 3 Jun 2002 09:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316355AbSFCNTS>; Mon, 3 Jun 2002 09:19:18 -0400
Received: from watsol.cc.columbia.edu ([128.59.39.139]:55264 "EHLO
	watsol.cc.columbia.edu") by vger.kernel.org with ESMTP
	id <S316039AbSFCNTR>; Mon, 3 Jun 2002 09:19:17 -0400
Date: Mon, 3 Jun 2002 09:19:15 -0400 (EDT)
From: Adam Trilling <agt10@columbia.edu>
To: bvermeul@devel.blackstar.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.19/20] KDE panel (kicker) not starting up
In-Reply-To: <Pine.LNX.4.33.0206031403190.24283-100000@devel.blackstar.nl>
Message-ID: <Pine.GSO.4.44.0206030918120.21429-100000@watsol.cc.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure you have read and write perms on your home directory.  I had
that happen due to a misplaced chown -R once.

This is not a kernel question, however, and probably shouldn't be on this
list.

adam

On Mon, 3 Jun 2002 bvermeul@devel.blackstar.nl wrote:

> The KDE panel (kicker) from KDE 3.0 (RedHat 7.3 issue) refuses to start
> up. I get a SIGPIPE in DCOP, and a SIGSEGV in kicker.
> This looks like something changed in regards to permissions, 'cause when I
> start KDE as root, it does work.
>
> Does anyone know what's happening?
>
> Regards,
>
> Bas Vermeulen
>
> --
> "God, root, what is difference?"
> 	-- Pitr, User Friendly
>
> "God is more forgiving."
> 	-- Dave Aronson
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


Adam Trilling
agt10@columbia.edu


char m[9999],*n[99],*r=m,*p=m+5000,**s=n,d,c;main(){for(read(0,r,4000);c=*r;
r++)c-']'||(d>1||(r=*p?*s:(--s,r)),!d||d--),c-'['||d++||(*++s=r),d||(*p+=c==
'+',*p-=c=='-',p+=c=='>',p-=c=='<',c-'.'||write(2,p,1),c-','||read(2,p,1));}

