Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273333AbRJKGxe>; Thu, 11 Oct 2001 02:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273141AbRJKGxY>; Thu, 11 Oct 2001 02:53:24 -0400
Received: from [213.255.45.210] ([213.255.45.210]:64263 "HELO
	web.g_stazioni.it") by vger.kernel.org with SMTP id <S273333AbRJKGxF>;
	Thu, 11 Oct 2001 02:53:05 -0400
Message-ID: <DF71F1B1D60BD5118D2C0004AC538C650D0B7C@DB_SRV>
From: "Lombardo, Federico" <FLombardo@grandistazioni.it>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Some strange things with kernel 2.4.11 (README PLZ)
Date: Thu, 11 Oct 2001 08:51:52 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've installed 2.4.11 on two different machine:
> 
> + IBM X340 SMP Linux Slackware 8
> + Compaq Proliant 1600 Linux Redhat 7.1
> 
> on both the machine I receive this strange problem:
> 
> root@norad:~# netstat -pltn
> Active Internet connections (only servers)
> Proto Recv-Q Send-Q Local Address           Foreign Address         State
> PID/Program name
> tcp        0      0 0.0.0.0:139             0.0.0.0:*               LISTEN
> 102/smbd
> tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN
> 100/httpd
> tcp        0      0 0.0.0.0:21              0.0.0.0:*               LISTEN
> 80/inetd
> tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN
> 82/sshd
> tcp        0      0 0.0.0.0:443             0.0.0.0:*               LISTEN
> 100/httpd
> root@norad:~# fuser -v 22/tcp
> root@norad:~#
> I receive this with ALL the services.. either lsof can't see anything
> with strace i can see the process that work correctly 
> after this I can't start anymore services by simple users... just like
> squid (on port 3128)
> 
> For better diagnostic, I've reinstalled 2.4.10 and all work fine.
> 
> 
> I'm not been "hacked" from someone... I've realized this after rebooting
> with the 2.4.11 bzImage.
> 
> 
> 
> 
> 
