Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282967AbRL0Wwd>; Thu, 27 Dec 2001 17:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282976AbRL0WwZ>; Thu, 27 Dec 2001 17:52:25 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:31225 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S282967AbRL0WwM>;
	Thu, 27 Dec 2001 17:52:12 -0500
Date: Thu, 27 Dec 2001 15:51:57 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Brian Craft <bcboy@thecraftstudio.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pasting arbitrary input to consoles
Message-ID: <20011227155157.L12868@lynx.no>
Mail-Followup-To: Brian Craft <bcboy@thecraftstudio.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011227141759.A19460@bcboy-linux.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011227141759.A19460@bcboy-linux.cisco.com>; from bcboy@thecraftstudio.com on Thu, Dec 27, 2001 at 02:17:59PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 27, 2001  14:17 -0800, Brian Craft wrote:
> Hi all -- I'm looking into ways of extending a voice control utility to
> work on the consoles. I was hoping there'd be a way to start the app
> during boot, or shortly after -- sorta like gpm starts and allows cut
> and paste in the console. It would be cool if the typing impaired could
> still run kudzu or linuxconf at boot, and have the consoles come up
> voice-enabled.  
> 
> Another option would be to run a terminal emulator, like screen, that was
> voice aware. Can such a program be wedged between the user and the os
> early during boot?

Well, you could also make the voice-aware shell as the default shell for
a given user, but that would not work for install systems like kudzu
where you are not in control of the boot environment (for that matter you
are not in control of the kernel for those systems either, so it doesn't
really matter).

Probably a good example of how this would work is screen(1) (as you have
mentioned) or script(1) which is a lot more light weight but may have
the necessary code to start from.

For X you could also make the voice recognition system an input method
(ala mouse, keyboard, tablet, joystick, etc), but that would only work
for X.  Come to think of it, doesn't the kernel already have an "input"
driver section for such things?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

