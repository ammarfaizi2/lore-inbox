Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289299AbSAIJ3v>; Wed, 9 Jan 2002 04:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289300AbSAIJ3r>; Wed, 9 Jan 2002 04:29:47 -0500
Received: from dns.logatique.fr ([213.41.101.1]:6397 "HELO
	persephone.dmz.logatique.fr") by vger.kernel.org with SMTP
	id <S289299AbSAIJ30>; Wed, 9 Jan 2002 04:29:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: Thomas Capricelli <tcaprice@logatique.fr>
To: Andreas Dilger <adilger@turbolabs.com>
Subject: Re: fs corruption recovery?
Date: Wed, 9 Jan 2002 10:28:57 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <3C3BB082.8020204@fit.edu> <20020108200705.S769@lynx.adilger.int>
In-Reply-To: <20020108200705.S769@lynx.adilger.int>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020109092659.2907323CBB@persephone.dmz.logatique.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday 09 January 2002 04:07, Andreas Dilger wrote:
> Try "e2fsck -B 4096 -b 32768 <device>" instead.

	I thought e2fsck was already trying the different superblocks present on the 
device. Why isn't e2fsck smart enought to look for then ? Is this an 
intended purpose ?

	Why do you use the -B option ? How can it be useful to force the block size 
? Especially if this one is different. 

Thanx,
Thomas
