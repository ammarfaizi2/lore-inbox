Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287860AbSANSXM>; Mon, 14 Jan 2002 13:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287862AbSANSXC>; Mon, 14 Jan 2002 13:23:02 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:63749 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288649AbSANSWu>; Mon, 14 Jan 2002 13:22:50 -0500
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
To: esr@thyrsus.com
Date: Mon, 14 Jan 2002 18:34:29 +0000 (GMT)
Cc: eli.carter@inet.com (Eli Carter),
        Michael.Lazarou@etl.ericsson.se ("Michael Lazarou (ETL)"),
        linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <20020114125228.B14747@thyrsus.com> from "Eric S. Raymond" at Jan 14, 2002 12:52:28 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16QBwD-0002So-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So why doesn't she use Red Hat or Mandrake's RPM update?  Maybe she's
> running something else.  (You ain't going to tell me Aunt Tillie is ready
> for Debian apt-get, either.)  Maybe she wants a kernel that's compiled

I've seen apt-get used successfully by people whom I wouldnt trust to have
a glass front door in case they forgot to open it. The trick being that
"upgrade" is a desktop item someone put there that runs apt for them (or
gnome-apt or kpackage)

Now to do everything you describe does not need her to configure a custom
kernel tree. Not one bit. You think apt or up2date build each user a custom
kernel tree ?

You basically build everything modular as the distro kernel did, you install
it as the distro kernel would. You build an initrd as the distro kernel did.

Not only does it work, but it needs no configuration because when the box
was installed someone already configured it
