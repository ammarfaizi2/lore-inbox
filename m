Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273754AbRIQX2Q>; Mon, 17 Sep 2001 19:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273753AbRIQX2G>; Mon, 17 Sep 2001 19:28:06 -0400
Received: from AMontpellier-201-1-1-55.abo.wanadoo.fr ([193.252.31.55]:65036
	"EHLO awak") by vger.kernel.org with ESMTP id <S273751AbRIQX2B> convert rfc822-to-8bit;
	Mon, 17 Sep 2001 19:28:01 -0400
Subject: Re: Forced umount (was lazy umount)
From: Xavier Bestel <xbestel@aplio.fr>
To: Alex Stewart <alex@foogod.com>
Cc: Tigran Aivazian <tigran@veritas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3BA68562.6030806@foogod.com>
In-Reply-To: <Pine.LNX.4.21.0109171144210.1357-100000@penguin.homenet> 
	<3BA68562.6030806@foogod.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.13.99+cvs.2001.09.17.19.25 (Preview Release)
Date: 18 Sep 2001 01:23:12 +0200
Message-Id: <1000768993.20059.5.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

le mar 18-09-2001 at 01:21 Alex Stewart a écrit :
[...]
> I see no reason why a properly functioning system should ever need to 
> truly force a umount.  Under normal conditions, if one really needs to 
> do an emergency umount, it should be possible to use fuser/kill/etc to 
> clean up any processes using the filesystem from userland and then 
> perform a normal umount to cleanly unmount the filesystem in question 
> (or, with lazy umount, this could conceivably even be done in the 
> reverse order).  The only reason for really-I-mean-it-forcing a umount 
> is if there is some problem which has caused one or more processes to 
> get permanently stuck in a state where they can't be killed (i.e. D 
> state), and thus can't release their hold on the filesystem.

Imagine you have a cdrom mounted with process reading it. You may want
to eject this cdrom without killing all processes, but just make them
know that there's an error somewhere, go read something else.
So it won't kill your shells, Nautilus/Konqueror, etc.

         Xav



