Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285163AbRLFOwm>; Thu, 6 Dec 2001 09:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285153AbRLFOwc>; Thu, 6 Dec 2001 09:52:32 -0500
Received: from 24.213.60.123.up.mi.chartermi.net ([24.213.60.123]:24772 "EHLO
	front1.chartermi.net") by vger.kernel.org with ESMTP
	id <S285163AbRLFOw2>; Thu, 6 Dec 2001 09:52:28 -0500
Message-ID: <3C0F8628.7010100@chartermi.net>
Date: Thu, 06 Dec 2001 08:52:24 -0600
From: Todd Inglett <tinglett@chartermi.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010914
X-Accept-Language: en-us
MIME-Version: 1.0
To: Marcelo Borges Ribeiro <marcelo@datacom-telematica.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: making an ide hd sleep
In-Reply-To: <002d01c17e48$6df98a20$1300a8c0@marcelo>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Borges Ribeiro wrote:

>Hi, I´d like to know if it's possible to put an ide hd to sleep after (for
>example) 15 min. idle (i don´t know if an hd under linux stays  idle that
>amount of time. ). I tried mount -o noatime and hdparm -S 150 /dev/hda, but
>it seems that when it sleeps it starts working after a few seconds (when it
>sleeps!). Is there a way to have this feature under linux?
>
This is more difficult that it sounds.  Section 4 of the Battery-Powered 
mini HOWTO (which is a bit out of date) has some useful advice.  You are 
doing it right...but something is touching the filesystem (or swap) on 
the drive.  It would be nice if there would be some way of enabling 
logging to say what process touched the filesystem.  Of course the 
logging itself would touch the filesystem (on a laptop :)).

  http://www.linuxdoc.org/HOWTO/mini/Battery-Powered-4.html

-todd

