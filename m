Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315441AbSEQNNf>; Fri, 17 May 2002 09:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315981AbSEQNNe>; Fri, 17 May 2002 09:13:34 -0400
Received: from chello062179036163.chello.pl ([62.179.36.163]:13703 "EHLO
	pioneer") by vger.kernel.org with ESMTP id <S315441AbSEQNNd>;
	Fri, 17 May 2002 09:13:33 -0400
Date: Fri, 17 May 2002 15:13:45 +0200 (CEST)
From: Tomasz Rola <rtomek@cis.com.pl>
To: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
cc: Halil Demirezen <halild@bilmuh.ege.edu.tr>, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: Just an offer
In-Reply-To: <Pine.GSO.4.05.10205171440170.11141-100000@mausmaki.cosy.sbg.ac.at>
Message-ID: <Pine.LNX.3.96.1020517150639.4483B-100000@pioneer>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Fri, 17 May 2002, Thomas 'Dent' Mirlacher wrote:

> On 17 May 2002, Halil Demirezen wrote:
> 
> > 
> > I wonder if there is a way of making the kernel decide whether it can boot successfully or not. For example, lets think of that i am compiling an update kernel not on the local machine but on any other pc using telnet or ssh emulators. And eventually it is time to reboot the machine and and run on the new kernel. However there has been an error during the compiling. - such as misconfiguration. Normally the machine will not boot and halt. So, is not there any way to reboot itself from the previous kernel after some time that it realizes it cannot boot properly. Maybe there is such a way. But, if not, this is an imaginary. Because i usually see these kind of problems ;)
> 
> 
> usually you'll use a hardware watchdog for that purpose. - but you need
> to be sure to instruct your bootloader to boot the old image when the watchdog
> reboots your machine ...

And this can be rather difficult to do with telnet :-)...

bye
T.

- --
** A C programmer asked whether computer had Buddha's nature.      **
** As the answer, master did "rm -rif" on the programmer's home    **
** directory. And then the C programmer became enlightened...      **
**                                                                 **
** Tomasz Rola          mailto:tomasz_rola@bigfoot.com             **


-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 5.0i for non-commercial use
Charset: noconv

iQA/AwUBPOUCDxETUsyL9vbiEQIJIACgreomBqpaNZSzPl+uKRvCCvczudUAn3df
z/JbB/7CXjlwpJhHhE8lHMW3
=vaAU
-----END PGP SIGNATURE-----

