Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311924AbSCXUZy>; Sun, 24 Mar 2002 15:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311930AbSCXUZo>; Sun, 24 Mar 2002 15:25:44 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1809 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311924AbSCXUZj>; Sun, 24 Mar 2002 15:25:39 -0500
Subject: Re: Problems with booting from SX6000
To: kjetiln@kvarteret.org (=?iso-8859-1?Q?Kjetil_Nyg=E5rd?=)
Date: Sun, 24 Mar 2002 20:41:35 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020324210811.B29097@kvarteret.org> from "=?iso-8859-1?Q?Kjetil_Nyg=E5rd?=" at Mar 24, 2002 09:08:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16pEo3-00079j-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have problems with booting from a Promise SX6000. 
> I installed rh7.2, but the kernel cannot mount the filesystem. I get error
> 6 on mounting the file-system.  But in 'linux rescue' it manages to mount 
> the filesystems fine.
> 
> What is wrong?

Firstly you must have recent firmware or the supertrak and SX6000 hang when
the module is loaded twice (as occurs when kudzu probes). Secondly you
should upgrade to the RH 2.4.9 errata kernel ASAP to avoid other weird hangs
under load that the newer i2o driver works around.

Alan
