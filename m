Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315447AbSEGN4s>; Tue, 7 May 2002 09:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315449AbSEGN4r>; Tue, 7 May 2002 09:56:47 -0400
Received: from kim.it.uu.se ([130.238.12.178]:58367 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S315447AbSEGN4q>;
	Tue, 7 May 2002 09:56:46 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15575.56603.518181.850621@kim.it.uu.se>
Date: Tue, 7 May 2002 15:56:43 +0200
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Anton Altaparmakov <aia21@cantab.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 57
In-Reply-To: <3CD7C9F1.2000407@evision-ventures.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki writes:
 > Uz.ytkownik Anton Altaparmakov napisa?:
 > > At 12:27 07/05/02, Martin Dalecki wrote:
 > > 
 > >> Tue May  7 02:37:49 CEST 2002 ide-clean-57
 > >>
 > >> Nuke /proc/ide. For explanations why, please see the frustrated 
 > >> comments in the previous change log.
 > > 
 > > 
 > > This is a big mistake IMO.
 > > 
 > > Nuking the ability to change settings, fair enough, but only if 
 > > alternative interface is provided for userspace to tweak everything, 
 > > otherwise provide the interface before you remove the existing one. 
 > > (There may be already another interface, I don't know...I am sure 
 > > someone will tell me if there is!)
 > 
 > Ehmm... There *is* one interface there. hdparm will help
 > you. Note: the upcomming release of hdparm should contain the

hdparm -i requires root privs. cat /proc/ide/${file} does not.
hdparm is NOT an acceptable substitute for /proc/ide/.

/Mikael
