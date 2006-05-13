Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWEMLTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWEMLTX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 07:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWEMLTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 07:19:23 -0400
Received: from smtp.ono.com ([62.42.230.12]:1186 "EHLO resmta04.ono.com")
	by vger.kernel.org with ESMTP id S932376AbWEMLTW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 07:19:22 -0400
Date: Sat, 13 May 2006 13:16:47 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: Mark Rosenstand <mark@borkware.net>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Executable shell scripts
Message-ID: <20060513131647.150b4b85@werewolf.auna.net>
In-Reply-To: <20060513110324.10A38146AF@hunin.borkware.net>
References: <20060513103841.B6683146AF@hunin.borkware.net>
	<1147517786.3217.0.camel@laptopd505.fenrus.org>
	<20060513110324.10A38146AF@hunin.borkware.net>
X-Mailer: Sylpheed-Claws 2.2.0cvs8 (GTK+ 2.9.0; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 May 2006 13:03:24 +0200 (CEST), Mark Rosenstand <mark@borkware.net> wrote:

> Arjan van de Ven <arjan@infradead.org> wrote:
> > On Sat, 2006-05-13 at 12:38 +0200, Mark Rosenstand wrote:
> > > Hi,
> > > 
> > > Is it in any (reasonable) way possible to make Linux support executable
> > > shell scripts? Perhaps through binfmt_misc?
> > 
> > ehhhhhh this is already supposed to work.
> 
> It doesn't:
> 
> bash-3.00$ cat << EOF > test
> > #!/bin/sh
> > echo "yay, I'm executing!"
> > EOF
> bash-3.00$ chmod 111 test

So you could execute the script if you ever could read it :)
Try with 755...

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.16-jam11 (gcc 4.1.1 20060330 (prerelease)) #2 SMP PREEMPT Fri
