Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264944AbTBATf5>; Sat, 1 Feb 2003 14:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264956AbTBATf4>; Sat, 1 Feb 2003 14:35:56 -0500
Received: from tag.witbe.net ([81.88.96.48]:62470 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S264944AbTBATfz>;
	Sat, 1 Feb 2003 14:35:55 -0500
From: "Paul Rolland" <rol@as2917.net>
To: "'Paul Rolland'" <rol@as2917.net>, "'John Bradford'" <john@grabjohn.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20 - Bunch of EXT2-fs error
Date: Sat, 1 Feb 2003 20:45:21 +0100
Message-ID: <002001c2ca2a$75298e10$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-reply-to: <001d01c2ca06$44c52320$2101a8c0@witbe>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmmm.... One point that may be of interest : 
root         2  0.0  0.0     0    0 ?        SW   Jan31   0:00 [keventd]
root         3  0.0  0.0     0    0 ?        SWN  Jan31   0:00
[ksoftirqd_CPU0]
root         4  0.0  0.0     0    0 ?        SWN  Jan31   0:00
[ksoftirqd_CPU1]
root         5  0.0  0.0     0    0 ?        SWN  Jan31   0:00
[ksoftirqd_CPU2]
root         6  0.0  0.0     0    0 ?        SWN  Jan31   0:00
[ksoftirqd_CPU3]
root         7  0.0  0.0     0    0 ?        SW   Jan31   0:00 [kswapd]
root         8  0.0  0.0     0    0 ?        SW   Jan31   0:00 [bdflush]
root         9  6.3  0.0     0    0 ?        SW   Jan31 124:10
[kupdated]
root        10  0.0  0.0     0    0 ?        SW   Jan31   0:00 [aacraid]
root        11  0.0  0.0     0    0 ?        SW   Jan31   0:00
[scsi_eh_0]
root       508  0.0  0.0  1480  624 ?        S    Jan31   0:55 syslogd
-m 0
ntp        628  0.0  0.0  1936 1932 ?        SL   Jan31   0:13 ntpd -U
ntp
root       651  0.0  0.0  2936 1192 ?        S    Jan31   0:00
/usr/sbin/sshd
root       683  0.0  0.0  2228  932 ?        S    Jan31   0:00 xinetd
-stayalive -reuse -pidfile /var/run/xinetd.pid
root       743  0.0  0.0  1460  620 ?        S    Jan31   0:00 crond
daemon     761  0.0  0.0  1448  572 ?        S    Jan31   0:00
/usr/sbin/atd
root       891  0.0  0.0  1388  452 tty1     S    Jan31   0:00
/sbin/mingetty tty1
root       892  0.0  0.0  1388  452 tty2     S    Jan31   0:00
/sbin/mingetty tty2
root       893  0.0  0.0  1388  452 tty3     S    Jan31   0:00
/sbin/mingetty tty3
root       894  0.0  0.0  1392  456 tty4     S    Jan31   0:00
/sbin/mingetty tty4
root       895  0.0  0.0  1392  452 tty5     S    Jan31   0:00
/sbin/mingetty tty5
root       896  0.0  0.0  1384  448 tty6     S    Jan31   0:00
/sbin/mingetty tty6
root      6127  0.0  0.0  2300 1124 ttyS0    S    11:06   0:00 login --
rol     
rol       6839  0.0  0.0  2904 1504 ttyS0    S    14:20   0:11 -tcsh
root      6861  0.0  0.0  2312  992 ttyS0    S    14:21   0:00 su root
root      6862  0.5  0.0  2524 1436 ttyS0    S    14:21   1:39 bash
root      8199  0.0  0.0  2636  728 ttyS0    R    19:44   0:00 ps
auxwwww

Very high CPU usage for kupdated.... Could this explain ?

Paul

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Paul Rolland
> Sent: Saturday, February 01, 2003 4:26 PM
> To: 'John Bradford'
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Linux 2.4.20 - Bunch of EXT2-fs error
> 
> 
> Not very sure about it....
> I got it before with 2.4.18 but sometime got a crash (kernel 
> oops), so I upgraded kernel to 2.4.20, put a remote console 
> on the machine to control and got that... but when it has 
> been initially powered with 2.4.20, it seems it was fine... 
> and it started later as I now got them.
> 
> This is one of the reason I wanted to restart it, but as 
> reboot is not accessible, I need to wait sometime...
> 
> Paul
> 
> > > I've a machine running Linux 2.4.20 and which is displaying
> > these on
> > > the console :
> > 
> > Has this only just started happening, or has the machine
> > never worked with 2.4.20?  What about older 2.4 kernels?
> > 
> > John
> > 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

