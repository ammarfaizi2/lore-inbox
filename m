Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262342AbVFUVg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262342AbVFUVg1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 17:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbVFUVdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 17:33:13 -0400
Received: from smtp06.auna.com ([62.81.186.16]:6319 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S262469AbVFUVbR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 17:31:17 -0400
Date: Tue, 21 Jun 2005 21:31:16 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: [PATCH] Pointer cast warnings in scripts/
To: linux-kernel@vger.kernel.org
References: <42B7F740.6000807@drzeus.cx>
	<Pine.LNX.4.61.0506211413570.3728@scrub.home> <42B80AF9.2060708@drzeus.cx>
	<Pine.LNX.4.61.0506211451040.3728@scrub.home> <42B80F40.8000609@drzeus.cx>
	<Pine.LNX.4.61.0506211515210.3728@scrub.home> <42B81ED6.7040706@drzeus.cx>
	<Pine.LNX.4.61.0506211612250.3728@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0506211612250.3728@scrub.home> (from
	zippel@linux-m68k.org on Tue Jun 21 16:14:52 2005)
X-Mailer: Balsa 2.3.3
Message-Id: <1119389476l.25237l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.212.68] Login:jamagallon@able.es Fecha:Tue, 21 Jun 2005 23:31:16 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.21, Roman Zippel wrote:
> Hi,
> 
> On Tue, 21 Jun 2005, Pierre Ossman wrote:
> 
> > A (somewhat unclean) solution is to make the type change based on the
> > platform. Are there any defines present to test if we're in a Solaris
> > environment? I don't have access to any Solaris machines myself so I
> > can't really test.
> 
> Just ignore it. If someone really cares, he has to redo the Solaris 
> specific changes properly (or live with warnings).
> 

pilgor:~> uname -a
SunOS pilgor 5.9 Generic_117171-07 sun4u sparc SUNW,Sun-Fire-V440 Solaris
pilgor:~> man strcpy
...
     int strcmp(const char *s1, const char *s2);

     int strncmp(const char *s1, const char *s2, size_t n);

     char *strcpy(char *s1, const char *s2);

     char *strncpy(char *s1, const char *s2, size_t n);

They look normal...
What is the problem with solaris ?

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.12-jam1 (gcc 4.0.1 (4.0.1-0.2mdk for Mandriva Linux release 2006.0))


