Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316524AbSEPALO>; Wed, 15 May 2002 20:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316525AbSEPALN>; Wed, 15 May 2002 20:11:13 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23818 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316524AbSEPALM>; Wed, 15 May 2002 20:11:12 -0400
Subject: Re: IO stats in /proc/partitions
To: miquels@cistron.nl (Miquel van Smoorenburg)
Date: Thu, 16 May 2002 01:30:19 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <abuqca$ipn$2@ncc1701.cistron.net> from "Miquel van Smoorenburg" at May 15, 2002 11:18:34 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17899v-0003Cl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Perhaps, but I had the opposite experience. I noticed by accident
> that iostat (as included in Debian) suddenly had working extended
> statistics. So there are *certainly* tools that get fixed by
> 2.4.19-pre7. I was pleasantly surprised.

Pretty much every vendor shipped the /proc/partitions changes and
has tools that will look for them. Its annoying to change stuff but
long term /proc/partitions is the wrong place for disk stats
