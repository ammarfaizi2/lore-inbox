Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280758AbRKSWhF>; Mon, 19 Nov 2001 17:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280760AbRKSWg5>; Mon, 19 Nov 2001 17:36:57 -0500
Received: from fit.edu ([163.118.5.1]:4551 "EHLO fit.edu")
	by vger.kernel.org with ESMTP id <S280758AbRKSWgs>;
	Mon, 19 Nov 2001 17:36:48 -0500
Message-ID: <3BF98AAB.6070202@fit.edu>
Date: Mon, 19 Nov 2001 17:41:47 -0500
From: Kervin Pierre <kpierre@fit.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Miguel Maria Godinho de Matos <Astinus@netcabo.pt>
CC: linux-kernel@vger.kernel.org
Subject: Re: Fwd: Hp 8xxx Cd writer
In-Reply-To: <EXCH01SMTP01aJ6pkNz0000350b@smtp.netcabo.pt>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Redhat 7.2 kernel has support for the HP 8200 cd writer.  Mine worked 
right after install. So upgrading to 7.2 might solve your problem.

"code maturity level" is the very first button (first colum, first row) 
on the make xconfig window.

Make sure you select scsi support as well.  And CONFIG_USB_LONG_TIMEOUT 
   might help as well, I think ( I can't remember it's location ).  This 
seemed to reduce ( haven't got one yet ) the number of the USB timeout 
messages I got when burning CDs.

-Kervin



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
> 
> 
> ----------  Forwarded Message  ----------
> 
> Subject: Hp 8xxx Cd writer
> Date: Mon, 19 Nov 2001 14:00:34 +0000
> From: Miguel Maria Godinho de Matos <Astinus@netcabo.pt>
> To: linux-kernel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Hi, I am crrently runnig linux red hat 7.2 with a 2.4.7 kernel ( i havent
> upgraded cause i am a newbie and haven't had he guts to do so ).
> 
> However i am trying to configure the kernel 2.4.14 which i actually have even
> acomplished to compile.
> 
> I have a doubt though! I have an externel cd-writer ( hp 8200 ) which is
> supported by the kernel, but in the make xconfig menu, that options appears
> in gray ( u can't select it ). As a lot of kernel options need some kind of
> pre-selected items, i am asking anyone who  knows what do i have to
> pre-select so i can choose the module for hp..... support in my usb kernel
> configuration menu.
> 
> If i didn't provide enough information plz tell me so!
> 
> Crying for help:
> 
> Astinus.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> -------------------------------------------------------
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


