Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266376AbSKGGfr>; Thu, 7 Nov 2002 01:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266379AbSKGGfr>; Thu, 7 Nov 2002 01:35:47 -0500
Received: from [212.3.242.3] ([212.3.242.3]:41454 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id <S266376AbSKGGfr>;
	Thu, 7 Nov 2002 01:35:47 -0500
Content-Type: text/plain; charset=US-ASCII
From: DevilKin <devilkin-lkml@blindguardian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.5.46] Problems with vfat mount umask on directories
Date: Thu, 7 Nov 2002 07:42:23 +0100
User-Agent: KMail/1.4.3
References: <200211070728.47941.devilkin-lkml@blindguardian.org>
In-Reply-To: <200211070728.47941.devilkin-lkml@blindguardian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211070742.23188.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 November 2002 07:28, DevilKin wrote:
> 'llo list.
>
> This morning I discovered I no longer could write on my vfat data partition
> as a normal user. The following line is present in /etc/fstab (and has
> worked before with atleast 2.5.40 and each and every 2.4 kernel I used)
>

And, as usual, if one would first READ the docs and then ask help, one would 
get a lot farther. Sorry bout this... :oP Just read the 
Documentation/filesystems/vfat.txt file, it says something about dmask (not 
present currently in the mount manpage) which made everything work again.

Another case of RTFM...

DK
-- 
Let's just say that where a change was required, I adjusted.  In every
relationship that exists, people have to seek a way to survive.  If you
really care about the person, you do what's necessary, or that's the
end.  For the first time, I found that I really could change, and the
qualities I most admired in myself I gave up.  I stopped being loud and
bossy ...  Oh, all right.  I was still loud and bossy, but only behind
his back."
		-- Kate Hepburn, on Tracy and Hepburn

