Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317102AbSF1TDv>; Fri, 28 Jun 2002 15:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317114AbSF1TDu>; Fri, 28 Jun 2002 15:03:50 -0400
Received: from [213.4.129.129] ([213.4.129.129]:34094 "EHLO tsmtp8.mail.isp")
	by vger.kernel.org with ESMTP id <S317102AbSF1TDu>;
	Fri, 28 Jun 2002 15:03:50 -0400
Date: Fri, 28 Jun 2002 21:08:16 +0200
From: Diego Calleja <diegocg@teleline.es>
To: Lionel Bouton <Lionel.Bouton@inet6.fr>
Cc: linux-kernel@vger.kernel.org, martin@daleki.de
Subject: Re: [BUG] IDE error in (un)stable trees
Message-Id: <20020628210816.15f281bd.diegocg@teleline.es>
In-Reply-To: <3D1C3856.3020000@inet6.fr>
References: <20020627212843.3439f49e.diegocg@teleline.es>
	<3D1C3856.3020000@inet6.fr>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jun 2002 12:20:06 +0200
Lionel Bouton <Lionel.Bouton@inet6.fr> escribió:

> 2/ timings might be messed up because of the FSB used (75MHz instead
> of 66MHz) on your configuration.
> 
> If you can, underclock your mainboard to 66MHz and see what happens.
> If it solves your problem, then dynamically computing timings from the
> FSB (in my TODO list but behind ATA133 support) will eventually solve
> your problem. Until then you could modify the timings by hand (I could
> provide you a patch for your specific configuration).

My mainboard supports 75 mhz of FSB, but strangely, the system can't
boot. The bios stops just before printing the message that says that a
cdrom has been detected. So I'm using 66 mhz FSB.


Diego Calleja
