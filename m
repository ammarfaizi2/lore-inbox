Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280781AbRKSXpV>; Mon, 19 Nov 2001 18:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280779AbRKSXpN>; Mon, 19 Nov 2001 18:45:13 -0500
Received: from tourian.nerim.net ([62.4.16.79]:4115 "HELO tourian.nerim.net")
	by vger.kernel.org with SMTP id <S280774AbRKSXo5>;
	Mon, 19 Nov 2001 18:44:57 -0500
Message-ID: <3BF99977.4090003@free.fr>
Date: Tue, 20 Nov 2001 00:44:55 +0100
From: Lionel Bouton <Lionel.Bouton@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011115
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.14 breaks NVIDIA-1.0-1541 console switching
In-Reply-To: <35E64A70B5ACD511BCB0000000004CA1095C9A@NT_CHEMO>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



PVotruba@Chemoprojekt.cz wrote:

>Hi,
>Please try to be more specific. Do you use VGA textmode console or NVidia
>console framebuffer? I had also some freezes due to console framebuffer,
>after returning closing X - the command line never appeared again. Try to
>use only textmode console, NVidia framebuffer is currently in EXPERI-MENTAL
>state :)
>
Very experimental on my box, it broked hard the last time I tried (SMP 
2.4.13-ac7) on my config :
lockup on first X -> fb console switch , SysRq worked for 
sync/umount/reboot, didn't tried blind "killall X" in initlevel 5 though 
(so X restart not tested).
If the maintainer wants some testing on a SMP with a Geforce2 MX, with 
every single partition reiserfs or ext3 mounted I can afford reboots now 
(130 GB on 4 IDE drives weren't especially fast to fsck)...


