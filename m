Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283468AbRLIOpO>; Sun, 9 Dec 2001 09:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283473AbRLIOpD>; Sun, 9 Dec 2001 09:45:03 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:17933 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S283468AbRLIOo5>; Sun, 9 Dec 2001 09:44:57 -0500
Message-ID: <3C1378D6.A5BAB1FA@linux-m68k.org>
Date: Sun, 09 Dec 2001 15:44:38 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Rene Rebe <rene.rebe@gmx.net>, linux-kernel@vger.kernel.org,
        alsa-devel@lists.sourceforge.net,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: devfs unable to handle permission: 2.4.17-pre[4,5] 
 /ALSA-0.9.0beta[9,10]
In-Reply-To: <200112090308.fB938N504764@vindaloo.ras.ucalgary.ca>
		<Pine.LNX.4.33.0112090447290.13049-100000@serv> <200112090448.fB94mbP05763@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:

> Oh, the "tar kludge". That script has been obsolete for over a year
> and a half. I should have removed it ages ago. I really should get
> around to doing that one day.

You should have done this a year ago. Permission management with the
"tar kludge" was a valid option so far and is currently in use. There
was no warning period that this future would be obsolete.
BTW from your devfsd-v1.3.20 release notes:

"NOTE: this release finally provides complete permissions management.
Manually (i.e. non driver or devfsd) created inodes can now be
restored when devfsd starts up. This requires v1.2 of the devfs core
(available in 2.4.17-pre1) for best operation."

The tar solution only works until 2.4.16, the new devfsd provides this
only with 2.4.17. I'll leave the final decision to Marcelo, whether he
accepts this or not. I shut up now, may someone else explain the meaning
of compatibility to you.

bye, Roman
