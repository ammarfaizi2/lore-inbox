Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263053AbTCWNYx>; Sun, 23 Mar 2003 08:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263055AbTCWNYx>; Sun, 23 Mar 2003 08:24:53 -0500
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:40145 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S263053AbTCWNYu>; Sun, 23 Mar 2003 08:24:50 -0500
Message-ID: <20030323133551.30594.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
To: mflt1@micrologica.com.hk, linux-kernel@vger.kernel.org
Date: Sun, 23 Mar 2003 14:35:51 +0100
Subject: Re: kernel 2.5.65/modutils 2.4.21/tools 0.9.10: /etc/modules.conf
    ignored?
X-Originating-Ip: 213.4.13.153
X-Originating-Server: ws5-7.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: Michael Frank <mflt1@micrologica.com.hk> 
Date: 	Sun, 23 Mar 2003 14:09:34 +0800 
To: linux-kernel@vger.kernel.org 
Subject: kernel 2.5.65/modutils 2.4.21/tools 0.9.10: /etc/modules.conf ignored? 
 
> - I have installed the above and encounter that all aliases in  
> /etc/modules.conf don't work with 2.4.65. The same system is ok  
> with 2.4.21-pre5. 
 
Uh? Are you using Rusty's latest 2.5.x modutils? If so, 
/etc/modules.conf has been superseded by /etc/modprobe.conf. 
Take a look at modutils configuration and extra utils, as there is 
a tools used to automatically migrate from modules.conf to 
modprobe.conf. 
 
I haven't had problems wirh module aliases. For example, 
iso9660 is called isofs in 2.5, so I set up an alias for this 
module. 
 
   Felipe 
 
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
