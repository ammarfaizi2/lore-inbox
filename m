Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278081AbRKNVvf>; Wed, 14 Nov 2001 16:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278085AbRKNVv0>; Wed, 14 Nov 2001 16:51:26 -0500
Received: from hank-fep7-0.inet.fi ([194.251.242.202]:26314 "EHLO
	fep07.tmt.tele.fi") by vger.kernel.org with ESMTP
	id <S278081AbRKNVvR>; Wed, 14 Nov 2001 16:51:17 -0500
Message-ID: <3BF2E72F.EBB1D591@pp.inet.fi>
Date: Wed, 14 Nov 2001 23:50:39 +0200
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.20aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Peter J. Braam" <braam@clusterfilesystem.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Makefile for external modules
In-Reply-To: <20011114011732.D18465@lustre.dyn.ca.clusterfilesystem.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Peter J. Braam" wrote:
> Rumor has it that there is now a simple way to build modules outside
> the kernel tree.  I'm told that you place a kernel style makefile in
> your directory and do:
> 
> make -C /usr/src/linux MOD_SUB_DIRS=/my/module/dir modules
> 
> It almost works, but loops. What is wrong?

cd /usr/src/linux && make SUBDIRS=/my/module/dir modules

Take a look at loop-AES makefile:
http://loop-aes.sourceforge.net/loop-AES-v1.4g.tar.bz2

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>

