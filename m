Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317480AbSFDLn5>; Tue, 4 Jun 2002 07:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316592AbSFDLn4>; Tue, 4 Jun 2002 07:43:56 -0400
Received: from AMontpellier-201-1-3-85.abo.wanadoo.fr ([193.252.1.85]:26091
	"EHLO awak") by vger.kernel.org with ESMTP id <S317537AbSFDLny> convert rfc822-to-8bit;
	Tue, 4 Jun 2002 07:43:54 -0400
Subject: Re: Need help tracing regular write activity in 5 s interval
From: Xavier Bestel <xavier.bestel@free.fr>
To: Padraig Brady <padraig@antefacto.com>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3CFCA2B0.4060501@antefacto.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.5 
Date: 04 Jun 2002 13:43:35 +0200
Message-Id: <1023191015.1067.75.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar 04/06/2002 à 13:21, Padraig Brady a écrit :
> As an aside, Nautilus (1.0.4) does stuff every 2 seconds
> (checking is there a CD inserted) that causes the disk LED to flash.
> The same action also causes the kernel (2.4.13) to fill up the ring
> buffer with: "VFS: Disk change detected on device ide1(22,0)".

It's not really Nautilus but a thing called magicdev. Just remove it and
your LED and syslog will be quieter.

	Xav

