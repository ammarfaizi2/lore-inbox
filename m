Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274554AbRIYSc5>; Tue, 25 Sep 2001 14:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274586AbRIYScr>; Tue, 25 Sep 2001 14:32:47 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:20329 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S274554AbRIYScf> convert rfc822-to-8bit; Tue, 25 Sep 2001 14:32:35 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: linux-kernel@vger.kernel.org
Subject: Re: all files are executable in vfat
Date: Tue, 25 Sep 2001 20:31:33 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.GSO.4.21.0109251332470.24321-100000@weyl.math.psu.edu> <3BB0C0D2.7070805@antefacto.com>
In-Reply-To: <3BB0C0D2.7070805@antefacto.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <E15lx0v-00004h-00@mrvdom04.kundenserver.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I also faced this  litte problem.

> Maybe by default (v)fat permissions should be
> a+x  on directories and a-x on files. But then

I could live with this solution.

I could also live with a dmask option. But then it would be great to have 
this option with every file system not only vfat.

> do a-x on files so this would be explicit? Maybe
> is would be better to put back the old logic? :-)

This i my preferred solution. I cannot image a situation where it is useful, 
to have a execution flag on all files, if the file system has a noexec flag.
But I see a lot of problems, like the Midnight Commander Logic.
On the other side, it is quite sensible to remove the execution flags from a 
file if you cannot execute them. 

greetings

Christian Bornträger
