Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290767AbSBLTdw>; Tue, 12 Feb 2002 14:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290616AbSBLTdm>; Tue, 12 Feb 2002 14:33:42 -0500
Received: from dialin-145-254-130-001.arcor-ip.net ([145.254.130.1]:2564 "EHLO
	dale.home") by vger.kernel.org with ESMTP id <S290503AbSBLTdd>;
	Tue, 12 Feb 2002 14:33:33 -0500
Date: Tue, 12 Feb 2002 20:33:23 +0100
From: Alex Riesen <fork0@users.sourceforge.net>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-dev] 2.5.4-pre1: zero-filled files reiserfs
Message-ID: <20020212203323.A1685@steel>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
In-Reply-To: <20020211172747.A1815@namesys.com> <Pine.LNX.4.44.0202121753360.15594-100000@Expansa.sns.it> <20020212200124.A2267@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020212200124.A2267@namesys.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2002 at 08:01:24PM +0300, Oleg Drokin wrote:
> Hello!
> 
>    What kind of corruption? Can we look at corrupted file if there is something
>    unusual?
>    What Linux Distribution do you run?
i have my own system (but with sysVinit), and am somewhat sure about unmounts.

>    You can check cleanness by looking into kernel messages.
>    If there is "replaying journal" message - umount was not clean.
I've had the "replaying journal" after "machine check exception".
But after this crash the filesystem was perfect. The zerofiles was before...


> 
> Bye,
>     Oleg
> On Tue, Feb 12, 2002 at 05:55:54PM +0100, Luigi Genoni wrote:
> > Sorry but I got a corrupted file also with 2.5.4. I could see it after the
> > reboot to 2.4.17. It was /etc/exports and it was OK since i edited it
> > running 2.5.4, and It was readable by exportfs, so it corrupted at reboot.
> > 
> > The reboot was clean, of course. Maybe wrong umount?

-alex
