Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbVIEMGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbVIEMGe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 08:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbVIEMGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 08:06:34 -0400
Received: from web8403.mail.in.yahoo.com ([202.43.219.151]:45951 "HELO
	web8403.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S1751119AbVIEMGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 08:06:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=FqbrqXGhaVHsLDtnEEnKPED3Y2WFzneCoK1/IvxUmdXDzRJvKTfAbkiJP8RSuN/a1jESjeNpe7BcdvybpcpTMAuHiTWlIbA4zs6pXezLU6gjgTh5piBo4n0abzdYMw7YqXKlOHNTz5pd1PoieSyhFJ4FilEmNGlFcn+5Mk/Loak=  ;
Message-ID: <20050905120625.70268.qmail@web8403.mail.in.yahoo.com>
Date: Mon, 5 Sep 2005 13:06:25 +0100 (BST)
From: vinay hegde <thisismevinay@yahoo.co.in>
Subject: Regarding the booting the linux kernel on a
 > PPC board.
To: linux-kernel@vger.kernel.org
Cc: thisismevinay@yahoo.co.in
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi All,
>  
> I am working on bringing up a PowerPC based board
> with Linux 2.6 kernel (Board supoort package).
> However, I am facing some problem with respect to
> debugging.
>  
> When I boot the board with the Linux kernel (BSP),
> the board hangs after printing the following
> information.
>  
> >>>>>>>>>>>>>>>>>>>>>>>
> 
> Network Loading from: /dev/enet0 
> 
> Client IP Address      = 192.168.4.38 
> Server IP Address      = 192.168.4.101 
> Gateway IP Address     = 192.168.4.253 
> Subnet IP Address Mask = 255.255.255.0 
> Boot File Name         = developer.kdi 
> Load Address           = 04000000 
> Buffer Size = 2000000 
> 
> Network Boot File Load Start - Press <ESC> to
> Bypass, <SPC> to Continue 
> 
> 
> Bytes Received =&6141952, Bytes Loaded =&6141952 
> Bytes/Second   =&511829, Elapsed Time =12 Second(s) 
> 
> Boot Device       =/dev/enet0 
> Boot File         =developer.kdi 
> Load Address      =04000000 
> Load Size         =005DB800 
> Execution Address =04000020 
> Execution Offset  =00000020 
> 
> Passing control to the loaded file/image. 
> loaded at:     00800000 00DD8800 
> zimage at:     008058E0 009933BB 
> initrd at:     00998000 00DD8800 
> avail ram:     00400000 00800000 
> 
> Linux/PPC load: console=ttyS0,9600 console=tty0
> root=/dev/sda2 
> console=ttyS0,9600 root=/dev/ram rw 
> Uncompressing Linux...done. 
> Now booting the kernel 
> 
> 
> >>>>>>>>>>>>>>>>>>>>>. 
> 
> I am going through the source code to figure out the
> problem, but unable to find out what is going wrong
> here.
> 
> Does anybody have any idea about the problem? Also,
> is it possible to print some debug messages at this
> point of booting? {Note that, in the early stage of
> booting process the serial is initialized and all
> the above mentioned messages (like Uncomressing
> Linux, Now booting the kernel etc) are printed. And
> immediately after printing the "now booting the
> kernel message,the serial is closed. This code is in
> uncompress_kernel() function in
> arch/ppc/boot/simple/misc.c file).
> 
> Can somebody help me with the above problem?
> 
> Thank you,
> 
> vinay hegde.
> 



	

	
		
__________________________________________________________ 
Yahoo! India Matrimony: Find your partner online. Go to http://yahoo.shaadi.com
