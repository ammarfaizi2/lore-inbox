Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129443AbRCTKh3>; Tue, 20 Mar 2001 05:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129446AbRCTKhS>; Tue, 20 Mar 2001 05:37:18 -0500
Received: from inet-smtp3.oracle.com ([205.227.43.23]:44942 "EHLO
	inet-smtp3.oracle.com") by vger.kernel.org with ESMTP
	id <S129443AbRCTKhB>; Tue, 20 Mar 2001 05:37:01 -0500
Message-ID: <3AB73199.A2D5208@oracle.com>
Date: Tue, 20 Mar 2001 11:31:53 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: alan@lxorguk.ukuu.org.uk
CC: linux-kernel@vger.kernel.org
Subject: 2.4.2-acXX hangs on boot if IrDA is in kernel
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

  tried as you suggested to config out IrDA and indeed the kernel boots.

 Even in -ac20 my Dell Latitude laptop hangs in the RH7.0 init sequence
  after printing the IRCOMM line. C-A-D doesn't do anything but I can use
  Magic Sysrq to reboot.

 I am available for further diagnostic investigation. Just in case, this
  is my IrDA h/w (booted into 2.4.3-pre4).

[root@princess /root]# findchip -v
Found SMC FDC37N958FR Controller at 0x3f0, DevID=0x01, Rev. 1
    SIR Base 0x3e8, FIR Base 0x290
    IRQ = 4, DMA = 3
    Enabled: yes, Suspended: no
    UART compatible: yes
    Half duplex delay = 3 us


 Thanks & ciao,

--alessandro      <alessandro.suardi@oracle.com> <asuardi@uninetcom.it>

Linux:  kernel 2.2.19p17/2.4.3p4 glibc-2.2 gcc-2.96-69 binutils-2.11.90.0.1
Oracle: Oracle8i 8.1.7.0.1 Enterprise Edition for Linux
motto:  Tell the truth, there's less to remember.
