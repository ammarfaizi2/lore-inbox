Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317346AbSFRH1P>; Tue, 18 Jun 2002 03:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317347AbSFRH1P>; Tue, 18 Jun 2002 03:27:15 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:60575 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S317346AbSFRH1O>; Tue, 18 Jun 2002 03:27:14 -0400
Date: Tue, 18 Jun 2002 09:10:10 +0200
From: Kristian Peters <kristian.peters@korseby.net>
To: kk maddowx <kk_maddox2000@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 kernel panics before and after boot
Message-Id: <20020618091010.5c9e37af.kristian.peters@korseby.net>
In-Reply-To: <20020617165244.44049.qmail@web21001.mail.yahoo.com>
References: <20020617093545.23389d53.kristian.peters@korseby.net>
	<20020617165244.44049.qmail@web21001.mail.yahoo.com>
X-Mailer: Sylpheed version 0.7.6claws (GTK+ 1.2.10; i386-redhat-linux)
X-Operating-System: i686-redhat-linux 2.4.19-pre10-ac2
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kk maddowx <kk_maddox2000@yahoo.com> wrote:
> Unfortunately I could not get memtest to work. I added
> the lines:
> 
> label=memtest
> image=/boot/memtest

It should be the reverse order:

image=/boot/memtest
        label=memtest

Please check that /boot/memtest exists.

> I have noticed that if the kernel does decide to panic
> on boot it will happen after the "Freeing unused
> memory" message is printed. Do you have any ideas what
> might be casuing this? TIA

Bad memory. ;-) Linux 2.4 only triggers that special sector at the beginning where 2.2 does not.

If memtest can't find any corruption it'd be worth trying an official kernel from redhat.

*Kristian

  :... [snd.science] ...:
 ::                             _o)
 :: http://www.korseby.net      /\\
 :: http://gsmp.sf.net         _\_V
  :.........................:
