Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261893AbRE3TYJ>; Wed, 30 May 2001 15:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261898AbRE3TX5>; Wed, 30 May 2001 15:23:57 -0400
Received: from ns.caldera.de ([212.34.180.1]:60907 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S261893AbRE3TXx>;
	Wed, 30 May 2001 15:23:53 -0400
Date: Wed, 30 May 2001 21:23:47 +0200
Message-Id: <200105301923.f4UJNl815303@ns.caldera.de>
From: Marcus Meissner <mm@ns.caldera.de>
To: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
Subject: Re: ln -s broken on 2.4.5
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <E155Ady-0006MX-00@the-village.bc.nu>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E155Ady-0006MX-00@the-village.bc.nu> you wrote:
>> I downloaded the linux 2.4.5 sources and built and installed them on my
>> system.  Since then, I've noticed strange file system behavior:

> What file system. Its find on my 2.4.5-ac with ext2

100% reproducible on NFS and EXT2 here, with following:

$ ln -s fupp/bar bar
$ ls -la bar
lrwxrwxrwx   1 marcus   users           3 May 30 20:30 bar -> bar
$ 

Ciao, Marcus
