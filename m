Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263051AbTCWNR7>; Sun, 23 Mar 2003 08:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263052AbTCWNR7>; Sun, 23 Mar 2003 08:17:59 -0500
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:16329 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S263051AbTCWNR6>; Sun, 23 Mar 2003 08:17:58 -0500
Message-ID: <20030323132859.26850.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Sun, 23 Mar 2003 14:28:59 +0100
Subject: ide-cd and kernel mod loader
X-Originating-Ip: 213.4.13.153
X-Originating-Server: ws5-7.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! 
 
In 2.5.65-mm4, if I compile ide-cd as a module, it's 
kernel module is not loaded automatically when 
accessing the CDROM block device (/dev/hdc in my 
case). 
 
Compiling IDE CD as a module, then doing a mount 
/cdrom fails with "/dev/hdc is not a valid block device". 
I haven't seen any messages on the kernel ring or 
/var/log/message. So, I need to manually do modprobe 
cdrom  and modprobe ide-cd. Then, mount will work. 
As this is a pain, I have opted to compile ide-cd into the 
kernel. This doesn't happen with other modules (i.e. 
they are loaded automatically. 
 
Is this a bug? 
 
   Thanks! 
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
