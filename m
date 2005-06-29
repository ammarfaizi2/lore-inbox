Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262528AbVF2K5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbVF2K5t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 06:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbVF2K5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 06:57:49 -0400
Received: from outmx001.isp.belgacom.be ([195.238.3.51]:37515 "EHLO
	outmx001.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S262532AbVF2KyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 06:54:19 -0400
Message-ID: <42C27DCD.1090107@skynet.be>
Date: Wed, 29 Jun 2005 12:54:05 +0200
From: Eric FAURE <eric.faure@skynet.be>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: tungsten t5 doesn't sync anymore with kernel 2.6.12
References: <42C0E879.5010605@skynet.be> <20050628083644.GA4246@kroah.com>
In-Reply-To: <20050628083644.GA4246@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,
I don't know if it's normal, but I see the line
visor_set_termios - nothing to change...
several times in the kernel 2.6.12 (not working one...)

here under, the output of kernel 2.6.12 and 2.6.11
thanks,
eric


here the dmesg with kernel 2.6.11 from the visor debug=1 (the working one):

drivers/usb/serial/visor.c: visor_write - port 1
visor ttyUSB1: visor_write - length = 8, data = 16 01 20 04 80 00 01 d4
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
visor ttyUSB1: visor_read_bulk_callback - length = 6, data = 01 c0 00 00 
00 4c
drivers/usb/serial/visor.c: visor_write_bulk_callback - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
visor ttyUSB1: visor_read_bulk_callback - length = 64, data = 96 01 00 
00 20 46 01 dd 80 01 42 40 00 01 73 6b 69 6e 53 6f 6c 30 00 00 00 00 00 
00 07 d5 04 1a 09 1b 0c 00 07 d5 04 1a 09 1b 0c 00 00 00 00 00 08 4a 05 
00 01 dd 53 6f 6c 69 74 61 69 72 65 20
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
visor ttyUSB1: visor_read_bulk_callback - length = 12, data = 50 61 63 
6b 20 53 6b 69 6e 73 00 00
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_write - port 1
visor ttyUSB1: visor_write - length = 6, data = 01 c1 00 00 00 08
drivers/usb/serial/visor.c: visor_write_bulk_callback - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_write - port 1
visor ttyUSB1: visor_write - length = 8, data = 16 01 20 04 80 00 01 de
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
visor ttyUSB1: visor_read_bulk_callback - length = 6, data = 01 c1 00 00 
00 48
drivers/usb/serial/visor.c: visor_write_bulk_callback - port 1
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
visor ttyUSB1: visor_read_bulk_callback - length = 64, data = 96 01 00 
00 20 42 01 de 80 01 3e 40 00 08 73 6d 66 72 70 73 79 73 00 01 00 00 00 
0f 07 d5 04 1a 01 0f 08 00 07 d5 04 1a 01 0f 08 00 07 d5 06 0c 10 14 05 
00 01 de 53 6f 6e 73 20 73 79 73 74 e8
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
visor ttyUSB1: visor_read_bulk_callback - length = 8, data = 6d 65 20 4d 
49 44 49 00
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_write - port 1
visor ttyUSB1: visor_write - length = 6, data = 01 c2 00 00 00 08
drivers/usb/serial/visor.c: visor_write_bulk_callback - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_write - port 1
visor ttyUSB1: visor_write - length = 8, data = 16 01 20 04 80 00 01 df
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
visor ttyUSB1: visor_read_bulk_callback - length = 6, data = 01 c2 00 00 
00 48
drivers/usb/serial/visor.c: visor_write_bulk_callback - port 1
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
visor ttyUSB1: visor_read_bulk_callback - length = 64, data = 96 01 00 
00 20 42 01 e0 80 01 3e 40 00 09 73 70 72 66 70 73 79 73 00 00 00 00 05 
35 07 d5 04 1a 01 0f 06 00 07 d5 06 1b 14 33 19 00 07 d5 06 0c 10 1f 01 
00 01 e0 53 61 76 65 64 20 50 72 65 66
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
visor ttyUSB1: visor_read_bulk_callback - length = 8, data = 65 72 65 6e 
63 65 73 00
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_write - port 1
visor ttyUSB1: visor_write - length = 6, data = 01 c3 00 00 00 08
drivers/usb/serial/visor.c: visor_write_bulk_callback - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_write - port 1
visor ttyUSB1: visor_write - length = 8, data = 16 01 20 04 80 00 01 e1
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
visor ttyUSB1: visor_read_bulk_callback - length = 6, data = 01 c3 00 00 
00 46
drivers/usb/serial/visor.c: visor_write_bulk_callback - port 1
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
visor ttyUSB1: visor_read_bulk_callback - length = 64, data = 96 01 00 
00 20 40 01 e1 80 01 3c 40 01 08 73 74 61 74 61 64 64 72 00 00 00 00 00 
01 07 d5 04 1a 01 0e 35 00 07 d5 04 1a 01 0e 35 00 07 d5 06 0c 10 14 06 
00 01 e1 41 64 64 72 65 73 73 53 74 61
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
visor ttyUSB1: visor_read_bulk_callback - length = 6, data = 74 65 73 44 
42 00
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_write - port 1
visor ttyUSB1: visor_write - length = 6, data = 01 c4 00 00 00 08
drivers/usb/serial/visor.c: visor_write_bulk_callback - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_write - port 1
visor ttyUSB1: visor_write - length = 8, data = 16 01 20 04 80 00 01 e2
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
visor ttyUSB1: visor_read_bulk_callback - length = 6, data = 01 c4 00 00 
00 40
drivers/usb/serial/visor.c: visor_write_bulk_callback - port 1
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
visor ttyUSB1: visor_read_bulk_callback - length = 64, data = 96 01 00 
00 20 3a 01 e2 80 01 36 40 00 ca 73 74 72 6d 44 47 43 4c 1b 58 00 00 02 
0e 07 92 04 0e 07 01 3b 00 07 d5 04 1a 00 31 08 00 00 00 00 00 08 4a 05 
00 01 e2 44 54 54 46 6f 6e 74 73 00 00
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_write - port 1
visor ttyUSB1: visor_write - length = 6, data = 01 c5 00 00 00 08
drivers/usb/serial/visor.c: visor_write_bulk_callback - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_write - port 1
visor ttyUSB1: visor_write - length = 8, data = 16 01 20 04 80 00 01 e3
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
visor ttyUSB1: visor_read_bulk_callback - length = 6, data = 01 c5 00 00 
00 44
drivers/usb/serial/visor.c: visor_write_bulk_callback - port 1
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
visor ttyUSB1: visor_read_bulk_callback - length = 64, data = 96 01 00 
00 20 3e 01 e3 80 01 3a 40 00 80 73 74 72 6d 50 44 61 74 00 00 00 00 01 
c5 07 d5 04 1a 00 34 24 00 07 d5 04 1a 00 34 24 00 00 00 00 00 08 4a 05 
00 01 e3 42 47 43 61 63 68 65 2d 50 44
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
visor ttyUSB1: visor_read_bulk_callback - length = 4, data = 61 74 00 00
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_write - port 1
visor ttyUSB1: visor_write - length = 6, data = 01 c6 00 00 00 08
drivers/usb/serial/visor.c: visor_write_bulk_callback - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_write - port 1
visor ttyUSB1: visor_write - length = 8, data = 16 01 20 04 80 00 01 e4
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
visor ttyUSB1: visor_read_bulk_callback - length = 6, data = 01 c6 00 00 
00 44
drivers/usb/serial/visor.c: visor_write_bulk_callback - port 1
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
visor ttyUSB1: visor_read_bulk_callback - length = 64, data = 96 01 00 
00 20 3e 01 e4 80 01 3a 40 00 80 73 74 72 6d 6c 6e 63 68 00 00 00 00 01 
c5 07 d5 04 1a 00 33 05 00 07 d5 04 1a 00 33 05 00 00 00 00 00 08 4a 05 
00 01 e4 42 47 43 61 63 68 65 2d 6c 6e
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
visor ttyUSB1: visor_read_bulk_callback - length = 4, data = 63 68 00 00
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_write - port 1
visor ttyUSB1: visor_write - length = 6, data = 01 c7 00 00 00 08
drivers/usb/serial/visor.c: visor_write_bulk_callback - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_write - port 1
visor ttyUSB1: visor_write - length = 8, data = 16 01 20 04 80 00 01 e5
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
visor ttyUSB1: visor_read_bulk_callback - length = 6, data = 01 c7 00 00 
00 46
drivers/usb/serial/visor.c: visor_write_bulk_callback - port 1
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
visor ttyUSB1: visor_read_bulk_callback - length = 64, data = 96 01 00 
00 20 40 01 e9 80 01 3c 40 01 08 74 69 74 6c 61 64 64 72 00 00 00 00 00 
01 07 d5 04 1a 01 0e 35 00 07 d5 04 1a 01 0e 35 00 07 d5 06 0c 10 14 06 
00 01 e9 41 64 64 72 65 73 73 54 69 74
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
visor ttyUSB1: visor_read_bulk_callback - length = 6, data = 6c 65 73 44 
42 00
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_write - port 1
visor ttyUSB1: visor_write - length = 6, data = 01 c8 00 00 00 08
drivers/usb/serial/visor.c: visor_write_bulk_callback - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_write - port 1
visor ttyUSB1: visor_write - length = 8, data = 16 01 20 04 80 00 01 ea
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
visor ttyUSB1: visor_read_bulk_callback - length = 6, data = 01 c8 00 00 
00 04
drivers/usb/serial/visor.c: visor_write_bulk_callback - port 1
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
visor ttyUSB1: visor_read_bulk_callback - length = 4, data = 96 00 00 05
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_write - port 1
visor ttyUSB1: visor_write - length = 6, data = 01 ff 00 00 00 06
drivers/usb/serial/visor.c: visor_write_bulk_callback - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_write - port 1
visor ttyUSB1: visor_write - length = 6, data = 2f 01 20 02 00 00
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
visor ttyUSB1: visor_read_bulk_callback - length = 6, data = 01 ff 00 00 
00 04
drivers/usb/serial/visor.c: visor_write_bulk_callback - port 1
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
visor ttyUSB1: visor_read_bulk_callback - length = 4, data = af 00 00 00
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_close - port 1
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
drivers/usb/serial/visor.c: visor_read_bulk_callback - nonzero read bulk 
status received: -2
usb 3-2: pilot-xfer timed out on ep0in
usb 3-2: USB disconnect, address 3
drivers/usb/serial/visor.c: visor_shutdown
visor ttyUSB0: Handspring Visor / Palm OS converter now disconnected 
from ttyUSB0
visor ttyUSB1: Handspring Visor / Palm OS converter now disconnected 
from ttyUSB1
visor 3-2:1.0: device disconnected
usb 3-2: new full speed USB device using uhci_hcd and address 4
drivers/usb/serial/visor.c: visor_probe
drivers/usb/serial/visor.c: palm_os_4_probe
usb 3-2: palm_os_4_probe - length = 20, data = 01 01 00 00 4c 73 66 72 
00 67 00 00 00 00 00 00 01 01 00 00
visor 3-2:1.0: Handspring Visor / Palm OS converter detected
usb 3-2: Handspring Visor / Palm OS converter now attached to ttyUSB0
usb 3-2: Handspring Visor / Palm OS converter now attached to ttyUSB1


and here the dmesg from kernel 2.6.12 (not working) :

usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
usbcore: registered new driver usbserial_generic
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/serial/usb-serial.c: USB Serial support registered for 
Handspring Visor / Palm OS
drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony 
Clie 3.5
drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony 
Clie 5.0
usbcore: registered new driver visor
drivers/usb/serial/visor.c: USB HandSpring Visor / Palm OS driver v2.1
usb 3-2: new full speed USB device using uhci_hcd and address 2
usb 3-2: device descriptor read/64, error -71
drivers/usb/serial/visor.c: visor_probe
drivers/usb/serial/visor.c: palm_os_4_probe
usb 3-2: palm_os_4_probe - length = 20, data = 01 01 00 00 4c 73 66 72 
00 67 00 00 00 00 00 00 01 01 00 00
visor 3-2:1.0: Handspring Visor / Palm OS converter detected
usb 3-2: Handspring Visor / Palm OS converter now attached to ttyUSB0
usb 3-2: Handspring Visor / Palm OS converter now attached to ttyUSB1
usb 3-2: USB disconnect, address 2
drivers/usb/serial/visor.c: visor_shutdown
visor ttyUSB0: Handspring Visor / Palm OS converter now disconnected 
from ttyUSB0
visor ttyUSB1: Handspring Visor / Palm OS converter now disconnected 
from ttyUSB1
visor 3-2:1.0: device disconnected
usb 3-2: new full speed USB device using uhci_hcd and address 3
drivers/usb/serial/visor.c: visor_probe
drivers/usb/serial/visor.c: palm_os_4_probe
usb 3-2: palm_os_4_probe - length = 20, data = 01 01 00 00 63 6e 79 73 
00 67 00 00 00 00 00 00 01 01 00 00
visor 3-2:1.0: Handspring Visor / Palm OS converter detected
usb 3-2: Handspring Visor / Palm OS converter now attached to ttyUSB0
usb 3-2: Handspring Visor / Palm OS converter now attached to ttyUSB1
drivers/usb/serial/visor.c: visor_open - port 1
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5402
drivers/usb/serial/visor.c: visor_set_termios - port 1
drivers/usb/serial/visor.c: visor_set_termios - data bits = 8
drivers/usb/serial/visor.c: visor_set_termios - parity = none
drivers/usb/serial/visor.c: visor_set_termios - stop bits = 1
drivers/usb/serial/visor.c: visor_set_termios - RTS/CTS is disabled
drivers/usb/serial/visor.c: visor_set_termios - XON/XOFF is disabled
drivers/usb/serial/visor.c: visor_set_termios - baud rate = 9600
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5403
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_set_termios - port 1
drivers/usb/serial/visor.c: visor_set_termios - nothing to change...
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
visor ttyUSB1: visor_read_bulk_callback - length = 6, data = 01 ff 00 00 
00 16
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_close - port 1
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
drivers/usb/serial/visor.c: visor_read_bulk_callback - nonzero read bulk 
status received: -2
drivers/usb/serial/visor.c: visor_open - port 1
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5402
drivers/usb/serial/visor.c: visor_set_termios - port 1
drivers/usb/serial/visor.c: visor_set_termios - nothing to change...
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5403
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_set_termios - port 1
drivers/usb/serial/visor.c: visor_set_termios - nothing to change...
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_close - port 1
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
drivers/usb/serial/visor.c: visor_read_bulk_callback - nonzero read bulk 
status received: -2
drivers/usb/serial/visor.c: visor_open - port 1
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5402
drivers/usb/serial/visor.c: visor_set_termios - port 1
drivers/usb/serial/visor.c: visor_set_termios - nothing to change...
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5403
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_set_termios - port 1
drivers/usb/serial/visor.c: visor_set_termios - nothing to change...
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_close - port 1
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
drivers/usb/serial/visor.c: visor_read_bulk_callback - nonzero read bulk 
status received: -2
usb 3-2: USB disconnect, address 3
drivers/usb/serial/visor.c: visor_shutdown
visor ttyUSB0: Handspring Visor / Palm OS converter now disconnected 
from ttyUSB0
visor ttyUSB1: Handspring Visor / Palm OS converter now disconnected 
from ttyUSB1
visor 3-2:1.0: device disconnected
usb 3-2: new full speed USB device using uhci_hcd and address 4
drivers/usb/serial/visor.c: visor_probe
drivers/usb/serial/visor.c: palm_os_4_probe
usb 3-2: palm_os_4_probe - length = 20, data = 01 01 00 00 4c 73 66 72 
00 67 00 00 00 00 00 00 01 01 00 00
visor 3-2:1.0: Handspring Visor / Palm OS converter detected
usb 3-2: Handspring Visor / Palm OS converter now attached to ttyUSB0
usb 3-2: Handspring Visor / Palm OS converter now attached to ttyUSB1



Greg KH wrote:
> On Tue, Jun 28, 2005 at 08:04:41AM +0200, Eric FAURE wrote:
> 
>>I tried loading the visor driver with debug=1
>>and here, the messages are differents from the kernel 2.6.11.12
>>dmesg kernel 2.6.12 output :
> 
> 
> How are they different?
> 
> thanks,
> 
> greg k-h
> 
> 
