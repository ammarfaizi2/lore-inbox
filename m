Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263101AbTCWOh1>; Sun, 23 Mar 2003 09:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263106AbTCWOh1>; Sun, 23 Mar 2003 09:37:27 -0500
Received: from imsp074.netvigator.com ([218.102.23.129]:43767 "EHLO
	imsp074.netvigator.com") by vger.kernel.org with ESMTP
	id <S263101AbTCWOhZ>; Sun, 23 Mar 2003 09:37:25 -0500
From: Michael Frank <mflt1@micrologica.com.hk>
To: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel 2.5.65/modutils 2.4.21/tools 0.9.10: /etc/modules.conf    ignored?
Date: Sun, 23 Mar 2003 22:47:17 +0800
User-Agent: KMail/1.5
References: <20030323133551.30594.qmail@linuxmail.org>
In-Reply-To: <20030323133551.30594.qmail@linuxmail.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
x-os: GNU/Linux 2.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303232247.17652.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe,

Thank you very much for this input. I use rusty's latest modutils and rpmbuild those from SRPM  never seing the documentation hidden in .

For those who might have the same problem, I found info in module-init-tools-0.9.10/README available from http://www.kernel.org/pub/linux/kernel/people/rusty/modules

It is working now.

Thank you you again,
Michael

On Sunday 23 March 2003 21:35, Felipe Alfaro Solana wrote:
> ----- Original Message -----
> From: Michael Frank <mflt1@micrologica.com.hk>
> Date: 	Sun, 23 Mar 2003 14:09:34 +0800
> To: linux-kernel@vger.kernel.org
> Subject: kernel 2.5.65/modutils 2.4.21/tools 0.9.10:
> /etc/modules.conf ignored?
>
> > - I have installed the above and encounter that all aliases
> > in /etc/modules.conf don't work with 2.4.65. The same system
> > is ok with 2.4.21-pre5.
>
> Uh? Are you using Rusty's latest 2.5.x modutils? If so,
> /etc/modules.conf has been superseded by /etc/modprobe.conf.
> Take a look at modutils configuration and extra utils, as
> there is a tools used to automatically migrate from
> modules.conf to modprobe.conf.
>
> I haven't had problems wirh module aliases. For example,
> iso9660 is called isofs in 2.5, so I set up an alias for this
> module.
>
>    Felipe

