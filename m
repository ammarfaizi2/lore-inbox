Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316127AbSFJUcI>; Mon, 10 Jun 2002 16:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316158AbSFJUcH>; Mon, 10 Jun 2002 16:32:07 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:23165 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S316127AbSFJUcG>; Mon, 10 Jun 2002 16:32:06 -0400
Date: Mon, 10 Jun 2002 22:28:10 +0200
From: Kristian Peters <kristian.peters@korseby.net>
To: David Ford <david+cert@blue-labs.org>
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: -ac series won't compile without fix
Message-Id: <20020610222810.14c88a1e.kristian.peters@korseby.net>
In-Reply-To: <3D05089D.6030604@blue-labs.org>
X-Mailer: Sylpheed version 0.7.6claws (GTK+ 1.2.10; i386-redhat-linux)
X-Operating-System: i686-redhat-linux 2.4.19-pre10-ac1
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford <david+cert@blue-labs.org> wrote:
> So in other words...
> 
> $ tar zxf linux.tar.bz2
> $ patch -p1 < patch
> $ cp /boot../.config .
> $ make oldconfig
> $ make dep clean
> $ make -j3 bzImage
> $ make dep
> $ make -j3 bzImage
> 
> That about cover it?  Still doesn't work.  I'm using -ac2.

I must do a "make mrproper" after applying the patch or after a failed "make dep". (saving the .config is important ;) Then it works for me..

*Kristian

  :... [snd.science] ...:
 ::                             _o)
 :: http://www.korseby.net      /\\
 :: http://gsmp.sf.net         _\_V
  :.........................:
