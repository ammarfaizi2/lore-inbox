Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262665AbRE3JNb>; Wed, 30 May 2001 05:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262663AbRE3JNL>; Wed, 30 May 2001 05:13:11 -0400
Received: from nic.lth.se ([130.235.20.3]:36742 "EHLO nic.lth.se")
	by vger.kernel.org with ESMTP id <S262660AbRE3JND>;
	Wed, 30 May 2001 05:13:03 -0400
Date: Wed, 30 May 2001 11:13:00 +0200
From: Jakob Borg <jakob@borg.pp.se>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5: USB audio crash again; now with info
Message-ID: <20010530111300.A13439@borg.pp.se>
In-Reply-To: <20010528074654.A625@borg.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010528074654.A625@borg.pp.se>
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux narayan 2.4.3 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2001 at 07:46:54AM +0200, Jakob Borg wrote:
> Hey;
> 
> 2.4.5 again seems to have the same bug that was introduced in 2.4.4, that
> the systems locks up completely when accessing and USB audio device. The
> system is a dual P2 400, details to be found in the attached dmesg and
> .config. The device in question is "device 3" after the kernel has
> enumerated devices (the other device being a webcam and there being no
> device 1).

After testing a little it seems that this problem only occurs with a kernel
compiled for SMP, and if the kernel is SMP it occurs even when only run on
one CPU (maxcpus=1). The UP kernel works fine on my machine.

//jb
