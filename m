Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275115AbRIYRMG>; Tue, 25 Sep 2001 13:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275116AbRIYRL5>; Tue, 25 Sep 2001 13:11:57 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:47033 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S275115AbRIYRLw>; Tue, 25 Sep 2001 13:11:52 -0400
Message-ID: <3BB0B9A7.2010906@antefacto.com>
Date: Tue, 25 Sep 2001 18:06:47 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nerijus Baliunas <nerijus@users.sourceforge.net>
CC: Alexander Viro <viro@math.psu.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: all files are executable in vfat
In-Reply-To: <Pine.GSO.4.21.0109251239250.24321-100000@weyl.math.psu.edu> <20010925170129.7AF958F659@mail.delfi.lt>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nerijus Baliunas wrote:

>On Tue, 25 Sep 2001 12:47:46 -0400 (EDT) Alexander Viro <viro@math.psu.edu> wrote:
>
>AV> > $ ls -l ls
>AV> > -rwxrwxrwx    1 nerijus  nerijus     45724 Rgs 25 18:12 ls
>AV> 
>AV> So use the right option for that - umask=111 and there you go.
>
>Actually I just few minutes ago thought about umask - yes, it helps,
>thank you. But now I cannot enter any directory as regular user.
>
I too used noexec to get around this problem. Is there anyway to get umask
to ignore directories? I.E. (v)fat should always leave directories 
executable
in my opinion?

Padraig.

