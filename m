Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129567AbRCFVu6>; Tue, 6 Mar 2001 16:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129568AbRCFVut>; Tue, 6 Mar 2001 16:50:49 -0500
Received: from atlrel2.hp.com ([156.153.255.202]:47084 "HELO atlrel2.hp.com")
	by vger.kernel.org with SMTP id <S129567AbRCFVug>;
	Tue, 6 Mar 2001 16:50:36 -0500
Message-ID: <3AA53F9C.EFDC7FA6@fc.hp.com>
Date: Tue, 06 Mar 2001 14:50:52 -0500
From: Khalid Aziz <khalid@fc.hp.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: otto.wyss@bluewin.ch
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB-keyboard not recognize after connection
In-Reply-To: <3AA54F40.A3643F3E@bluewin.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Otto Wyss wrote:
> 3. How can I get more information what's happening? Is there any
> USB-log/-trace accessable after the restart of linux? And whom/where do
> I have to send it?
> 

If you compiled your kernel with "USB verbose debug messages"
(CONFIG_USB_DEBUG) enabled, USB subsystem should log a message every
time a device is connected and disconnected. These messages will be
there in /var/log/messages if this file survives hard reset. These
messages can show you if USB detected a reconnect from your keyboard and
mouse the last time you switched from mac to PC.


====================================================================
Khalid Aziz                             Linux Development Laboratory
(970)898-9214                                        Hewlett-Packard
khalid@fc.hp.com                                    Fort Collins, CO
