Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289839AbSBLRBp>; Tue, 12 Feb 2002 12:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290312AbSBLRBf>; Tue, 12 Feb 2002 12:01:35 -0500
Received: from angband.namesys.com ([212.16.7.85]:44416 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S289839AbSBLRB0>; Tue, 12 Feb 2002 12:01:26 -0500
Date: Tue, 12 Feb 2002 20:01:24 +0300
From: Oleg Drokin <green@namesys.com>
To: Luigi Genoni <kernel@Expansa.sns.it>
Cc: Alex Riesen <fork0@users.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-dev] 2.5.4-pre1: zero-filled files reiserfs
Message-ID: <20020212200124.A2267@namesys.com>
In-Reply-To: <20020211172747.A1815@namesys.com> <Pine.LNX.4.44.0202121753360.15594-100000@Expansa.sns.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0202121753360.15594-100000@Expansa.sns.it>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   What kind of corruption? Can we look at corrupted file if there is something
   unusual?
   What Linux Distribution do you run?

   You can check cleanness by looking into kernel messages.
   If there is "replaying journal" message - umount was not clean.

Bye,
    Oleg
On Tue, Feb 12, 2002 at 05:55:54PM +0100, Luigi Genoni wrote:
> Sorry but I got a corrupted file also with 2.5.4. I could see it after the
> reboot to 2.4.17. It was /etc/exports and it was OK since i edited it
> running 2.5.4, and It was readable by exportfs, so it corrupted at reboot.
> 
> The reboot was clean, of course. Maybe wrong umount?
