Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290153AbSAKXHS>; Fri, 11 Jan 2002 18:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290157AbSAKXHM>; Fri, 11 Jan 2002 18:07:12 -0500
Received: from tourian.nerim.net ([62.4.16.79]:37904 "HELO tourian.nerim.net")
	by vger.kernel.org with SMTP id <S290153AbSAKXHA>;
	Fri, 11 Jan 2002 18:07:00 -0500
Message-ID: <3C3F7013.8080603@inet6.fr>
Date: Sat, 12 Jan 2002 00:06:59 +0100
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020109
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: IDE Patch SIS ATA100
In-Reply-To: <Pine.LNX.4.10.10201080709060.991-100000@master.linux-ide.org> <3C3B6526.44A03F39@kolumbus.fi> <3C3B711D.1050400@free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lionel Bouton wrote:

> Jussi Laako wrote:
> 
> 
> I'm on it. Had some intermittent successes and thought to have a correct 
> patch until today (one 2002 week with ATA100)...
> But I had a bugreport today and same dma problems on my machine after a 
> BIOS flashing and a new drive in the system.
> Currently in heavy debugging.
> 


Debugging ended. Patch cleaned from debugging code submitted to Andre.
After numerous bug reports and google search I understood that the 
problem is an *hardware* one on my board.


> PB: chip seems to init itself correctly on extended periods of time on 
> my config! Makes testing rather difficult :-(
> 
> For example, with the *exact* same code this evening I had:
> - a system freeze just after /sbin/init load,
> - a crash after ext3 fs errors before init,
> - a somewhat working boot (some weird library errors caused "ip" to not 
> work),
> - a fully functionnal system (no error reported, some file copies, 
> reboot with ide=nodma, e2fsck -f -> no error).
> 


Should have been 100% sure this was an hardware pb at this time. Non 
deterministic behaviour in my code could not have had any other source.

People encountering problems using SIS chipsets should try the driver 
available here:

http://gyver.homeip.net/sis5513/index.html

LB.



