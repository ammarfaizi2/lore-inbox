Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbVCCUvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbVCCUvD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 15:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262583AbVCCUsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 15:48:40 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:3032 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262538AbVCCUoM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 15:44:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Dv5jnnd/bdE9q5zjtc5g2EocdgjQ/80OhyqFadEeRoKIa7oXUbezWhis5+FEumTVaJAjFGMiVV04/fHzYGbDyTL8eJBFSu0IQYVHppbbC3bfiL0uwCNKMR8TWuZK6RuRA9bQmd+TUPM5qDZ/MCwJ5biX+l9R1w713rsr2rQNhh8=
Date: Thu, 3 Mar 2005 21:43:58 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Dave Jones <davej@redhat.com>
Cc: akpm@osdl.org, torvalds@osdl.org, jgarzik@pobox.com,
       rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-Id: <20050303214358.3c842a01.diegocg@gmail.com>
In-Reply-To: <20050303052100.GA22952@redhat.com>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
	<20050302230634.A29815@flint.arm.linux.org.uk>
	<42265023.20804@pobox.com>
	<Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org>
	<20050303002733.GH10124@redhat.com>
	<20050302203812.092f80a0.akpm@osdl.org>
	<20050303052100.GA22952@redhat.com>
X-Mailer: Sylpheed version 1.9.4 (GTK+ 2.6.2; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 3 Mar 2005 00:21:01 -0500,
Dave Jones <davej@redhat.com> escribió:

> bunch of IBM thinkpads. As it turns out there are quite a lot of these
> out there, so when I released a 2.6.10 update for Fedora, bugzilla lit
> up like a christmas tree with "Hey, where'd my sound go?" reports.
> (It was further confused by a load of other sound card problems, but
>  thats another issue).  This got so out of control, Alan asked the ALSA
> folks to take a look, and iirc Takashi figured out what had caused the
> problem, and it got fixed in the ALSA folks tree, and subsequently, in 2.6.11rc.
> 
> Now, during all this time, there hadn't been any reports of this problem
> at all on Linux-kernel. Not even from Linus' tree, let alone -mm.
> Which amazes me given how widespread the problem was.

Part of that problem may be that reporting bugs to the kernel is hard for everybody except
kernel hackers. bugzilla.kernel.org is there but not many people look at it (which I
understand, using bugzilla is painfull, altough basing all your development strategy around
it _is_ rewarding, as happens in gnome/etc, where the release announcement includes a
list bugzilla numbers which point to fixed bugs or "new feature" bugs in the case of new
features).

That could be very well at last as important as the "release numbering". If there're bugs
out there and people are not reporting them, the "release numbering" you choose is
irrelevant since bugs are not being reported and you can't fix them. Just my humble
opinion.
