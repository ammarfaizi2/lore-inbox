Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316895AbSEVIzz>; Wed, 22 May 2002 04:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316898AbSEVIzy>; Wed, 22 May 2002 04:55:54 -0400
Received: from [195.63.194.11] ([195.63.194.11]:11022 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316895AbSEVIzx>; Wed, 22 May 2002 04:55:53 -0400
Message-ID: <3CEB4E43.5020203@evision-ventures.com>
Date: Wed, 22 May 2002 09:52:35 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Nick Kurshev <nickols_k@mail.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: /dev/port BUG and possible workaround
In-Reply-To: <20020522124116.680f59b8.nickols_k@mail.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Nick Kurshev napisa?:

...

> 800=inl(CFC)
> 2. Wrong log with using of /dev/port:

...

> But it seems that nobody uses this device. Then what is goal
> of implementing of this device?

Basically the goal is that contrary to some silly /proc
stuff which is "en vouge" nowadays you have the ability to
controll port access by using normal user permission control
semantics of unix file access permissions, by giving /dev/port
a proper group and so on. This is legacy crap of course, since
the above goal can be reached by using a apache-suexec alike wrapper
as well... even with more fine grained resolution of access controll.

