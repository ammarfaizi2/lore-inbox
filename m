Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313190AbSDJPPq>; Wed, 10 Apr 2002 11:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313200AbSDJPPp>; Wed, 10 Apr 2002 11:15:45 -0400
Received: from zeus.kernel.org ([204.152.189.113]:4070 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S313190AbSDJPPp>;
	Wed, 10 Apr 2002 11:15:45 -0400
Date: Wed, 10 Apr 2002 16:24:43 +0200
From: Piotr Esden-Tempski <pe1724@bingo-ev.de>
To: Amol Kumar Lad <amolk@ishoni.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reducing root filesystem
Message-ID: <20020410142443.GA4665@bingo-ev.de>
In-Reply-To: <7CFD7CA8510CD6118F950002A519EA3001067D06@leonoid.in.ishoni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
You can try using dietlibc (http://www.fefe.de/dietlibc/) and other
tools listed on http://www.fefe.de/ . There is also a project rewriting
shell tools in assembler but I do not remember the name. This should
reduce required root space a little.

cheers Esden

On Wed, Apr 10, 2002 at 07:38:09PM +0530, Amol Kumar Lad wrote:
> Hi,
>   I am porting Linux to an embedded system. Currently my rootfilesystem is
> around 2.5 MB (after keeping it to minimal and adding tools like busybox). I
> want to furthur reduce it to say maximum of 1.5 MB. 
> Please suggest some link/references where I can find the details to optimise
> my root filesystem
> 
> thanks
> Amol
> 
> please CC me
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
bChat2: http://bchat2.bingo-ev.de                       ___  ___  ___  _  _
bChat: http://bchat.bingo-ev.de                        | _ || _ || __|| |//
ROCK LINUX: www.rocklinux.org                          ||_|||| ||||   |  /
-Born to run kill -9 win                               |  _|||_||||__ |  \
-"Ignorance is bliss." (Matrix)                        ||\\ |_LINUX__||_|\\
GPG Public Key Block: http://www.esden.net/me/esden-key-2002-01-17.asc
