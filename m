Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275031AbRJUVqn>; Sun, 21 Oct 2001 17:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275823AbRJUVqd>; Sun, 21 Oct 2001 17:46:33 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3844 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S275767AbRJUVqX>; Sun, 21 Oct 2001 17:46:23 -0400
Subject: Re: The new X-Kernel !
To: seanc@gearboxsoftware.com (Sean Cavanaugh)
Date: Sun, 21 Oct 2001 22:52:53 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000801c15a78$b79a4280$150a10ac@gearboxsoftware.com> from "Sean Cavanaugh" at Oct 21, 2001 04:38:26 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15vQWb-00085J-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Normal users really don't need to see the startup message spam on boot,
> unless there is an error (at which point it should be able to present
> the error to the user).  Any kind of of progress indicator' s really

The big problem is making sure they then see the error, and the previous
progress information. On a solid hang they might not get it

> more for feedback that the boot is proceeding ok.  The fact the boot
> sequence isn't even interactive should also be a big hint that it isn't
> really necessary (except for kernel and driver developers).

You are thinking the small picture not the big one. If you are going to
graphical in init then you want to make full use of the graphical
environment to clearly show things like parallel fsck behaviour, what
servers are starting up (with pretty icons) and to do interactive things 
like starting a rescue shell, going single user, pausing the boot,
changing run level, interactive boot.

Alan
