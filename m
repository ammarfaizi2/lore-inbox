Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289162AbSA1Ihr>; Mon, 28 Jan 2002 03:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289166AbSA1Ihh>; Mon, 28 Jan 2002 03:37:37 -0500
Received: from web9205.mail.yahoo.com ([216.136.129.38]:46993 "HELO
	web9205.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S289162AbSA1Ih1>; Mon, 28 Jan 2002 03:37:27 -0500
Message-ID: <20020128083726.83324.qmail@web9205.mail.yahoo.com>
Date: Mon, 28 Jan 2002 00:37:26 -0800 (PST)
From: Alex Davis <alex14641@yahoo.com>
Subject: I've stopped the 'Spurious interrupts on IRQ7'
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I added the following line to /etc/lilo.conf

append = "parport=0x378,7"

and re-ran lilo. I also noticed that the 'ERR' field in 
/proc/interrupts stays at 0, whereas before the mod it
was increasing.

__________________________________________________
Do You Yahoo!?
Send your FREE holiday greetings online!
http://greetings.yahoo.com
