Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280703AbRKSU6M>; Mon, 19 Nov 2001 15:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280690AbRKSU6D>; Mon, 19 Nov 2001 15:58:03 -0500
Received: from schwerin.p4.net ([195.98.200.5]:22794 "EHLO schwerin.p4.net")
	by vger.kernel.org with ESMTP id <S280684AbRKSU5u>;
	Mon, 19 Nov 2001 15:57:50 -0500
Message-ID: <3BF9728E.2080106@p4all.de>
Date: Mon, 19 Nov 2001 21:58:54 +0100
From: Michael Dunsky <michael.dunsky@p4all.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: de, en
MIME-Version: 1.0
To: Miguel Maria Godinho de Matos <Astinus@netcabo.pt>
CC: linux-kernel@vger.kernel.org
Subject: Re: Fwd: Hp 8xxx Cd writer
In-Reply-To: <EXCH01SMTP01aJ6pkNz0000350b@smtp.netcabo.pt>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Maria Godinho de Matos wrote:

> Guys u have been great for answering me but........
> 
> Lets see, almost all of u tell to look in my current configuration, so i can 
> load it when i am going to recompile the kernel right?
> 
> Well the major problem is that in my current configuration, red hat doesn't 
> also have the suppor for hp cd writer 8200!
> 
> So even if i do so, which i did, it doesn't solve my problem as those modules 
> aren't loaded in my current kernel!
> 
> John, u say i probably have to say yes to experimental drivers right?, in 
> which menu can i state that, cause i am looking the xconfig menus as i am 
> typing and i don't seem able to find that option. Also u may be right, but ho 
> 8200 has been supported since the firs 2.4 kernel, so they may not be 
> experimental in the 2.4.14 ( i am probably wrong as i don't understand much 
> of the subject ).
> 
> Plz guys, can one of u try do make xconfig or make menuconfig as if u were to 
> compile the kernel so u can look at the usb menu and check which my problem 
> is and how to solve it?
> 
> Once again tks for your cooperation.
> 
> Gratefull Astinus.
> 


sure!

# make xconfig

Click "Code maturity level options".
There you find "Prompt for development and or incomplete code/drivers".
That's where the "experimental" stuff will be enabled.
Say "Y" there and go back to main menu.
Now go to USB support, use your option (y or m) for main USB-support and 
say "y" or "m" to "USB Mass Storage support". Now you can choose "HP 
CD-Writer 82xx-support"

ciao

Michael

