Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280676AbRKSUEs>; Mon, 19 Nov 2001 15:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280678AbRKSUEi>; Mon, 19 Nov 2001 15:04:38 -0500
Received: from mirza.iland.net ([204.87.167.69]:53133 "HELO paco2.iland.net")
	by vger.kernel.org with SMTP id <S280676AbRKSUE0>;
	Mon, 19 Nov 2001 15:04:26 -0500
Date: 19 Nov 2001 14:04:25 -0600
Date: Mon, 19 Nov 2001 14:04:25 -0600
From: Chris Kennedy <ckennedy-kernel@iland.net>
To: Miguel Maria Godinho de Matos <Astinus@netcabo.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hp 8xxx Cd writer
Message-ID: <20011119140425.A9262@iland.net>
In-Reply-To: <EXCH01SMTP01CJiLyNf000018e2@smtp.netcabo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <EXCH01SMTP01CJiLyNf000018e2@smtp.netcabo.pt>; from Astinus@netcabo.pt on Mon, Nov 19, 2001 at 02:00:34PM +0000
X-Chris-Kennedy: Use Linux and prosper :)
X-URL: http://www.groovy.org/
X-Disclaimer: My opinions do not necessarily represent the opinions of my employer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It needs to have the SCSI emulation enabled, and then the SCSI 
generic device (sg) and also the SCSI/USB mass storage support
plus scsi CDROM support.  It treats it as scsi cdrom basically,
which is why all the scsi stuff is needed.

Chris Kennedy
On Mon, Nov 19, 2001 at 02:00:34PM +0000, Miguel Maria Godinho de Matos wrote:
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

-- 
Chris Kennedy / ckennedy@iland.net / (660) 829-4638x117
I-Land Internet Services / Network Operations Center
     \|/ ____ \|/
     "@'/ .. \`@"   
     /_| \__/ |_\
        \__U_/ -Linux SPARC Kernel Oops
