Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129747AbRATFdC>; Sat, 20 Jan 2001 00:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130356AbRATFcv>; Sat, 20 Jan 2001 00:32:51 -0500
Received: from fes-qout.whowhere.com ([209.185.123.96]:39617 "HELO
	mailcity.com") by vger.kernel.org with SMTP id <S129747AbRATFcn>;
	Sat, 20 Jan 2001 00:32:43 -0500
To: linux-kernel@vger.kernel.org
Date: Sat, 20 Jan 2001 00:32:14 -0500
From: "Gregg Lloyd" <gregg_99@lycos.com>
Message-ID: <FIGIMNBNAMJCJAAA@mailcity.com>
Mime-Version: 1.0
X-Sent-Mail: off
Reply-To: gregg_99@mailcity.com
X-Mailer: MailCity Service
Subject: Kernel is compiled but LILO wont boot it...
X-Sender-Ip: 209.148.70.123
Organization: Lycos Mail  (http://mail.lycos.com:80)
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
I did compile my new kernel 2.4 on a Red Hat 6.0 Linux  
system. My Linux System  was installed so that it can 
boot from a floppy.
So on the boot floppy, I have LILO (On the hard drive, 
there's also LILO). 
For booting my new kernel (/boot/vmlinuz-2.4.0), I added 
following stanza to /etc/lilo.conf (the one on the hard drive): 
image=/boot/vmlinuz-2.4.0
label=linux2.4
root=/dev/hda2
read-only. Lilo was correctly saved. But when I rebooted the system
with the boot floppy, LILO wont display linux2.4 so that I can boot with it!
LILO would only show up the old linux. 
I when adding the same stanza (as previously mentionned) to /etc/lilo.conf
that is on the floppy. But the problem is still the same: I do not have the choice to boot with linux2.4!


Thanks



Get your small business started at Lycos Small Business at http://www.lycos.com/business/mail.html
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
