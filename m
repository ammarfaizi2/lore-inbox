Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290946AbSCBK7K>; Sat, 2 Mar 2002 05:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292000AbSCBK7B>; Sat, 2 Mar 2002 05:59:01 -0500
Received: from gate.perex.cz ([194.212.165.105]:15368 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S290946AbSCBK6p>;
	Sat, 2 Mar 2002 05:58:45 -0500
Date: Sat, 2 Mar 2002 11:58:32 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Reinhard Wolfgang Kreiner <rkreiner@sbox.tugraz.at>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: PROBLEM: 2.5.5 with Alsa, kernel BUG at slab.c:1459
In-Reply-To: <Pine.LNX.4.33.0203011709020.15390-100000@pluto.tu-graz.ac.at>
Message-ID: <Pine.LNX.4.33.0203021150350.681-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2002, Reinhard Wolfgang Kreiner wrote:

> Hello, 
> 
> I tested kernel 2.5.5, 2.5.5-pre1 with alsa-sound-drivers... 
> it runs great, but the system is freezing if i 
> shutdown the system and i get kernel BUG at slab.c:1459!!!
> 
> i tried different combination, the problem only orrur
> if im _using_ the soundcards.
>  
> unloading the modules manually, the same problem
> only on shutdown.
> seems to be freeing some resouces in memory?

We fixed this problem in our CVS (it's in cs4231_lib.c).
What is worring me why /proc/asound shows '???' for card name.
Can you try ALSA 0.9.0beta12 and contect me privately, if it works?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


