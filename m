Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264915AbSLQLGW>; Tue, 17 Dec 2002 06:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264919AbSLQLGW>; Tue, 17 Dec 2002 06:06:22 -0500
Received: from cpe.atm2-0-1071115.0x50c4d862.boanxx10.customer.tele.dk ([80.196.216.98]:12477
	"EHLO fugmann.dhs.org") by vger.kernel.org with ESMTP
	id <S264915AbSLQLGV>; Tue, 17 Dec 2002 06:06:21 -0500
Message-ID: <3DFF070A.6010804@fugmann.dhs.org>
Date: Tue, 17 Dec 2002 12:14:18 +0100
From: Anders Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021210 Debian/1.2.1-3
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: mousewheel not working.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'm having troubles getting the mosuewheel on my logitech ps/2 mouseman+
(model M-C48) to work, under 2.5.52. Do I need to add something special 
to the kernel boot parameters to instruct the driver that my mouse 
carries 5 buttons?

dmesg:
device class 'input': registering
register interface 'mouse' with class 'input'
mice: PS/2 mouse device common for all mice
input: PS2++ Logitech Wheel Mouse on isa0060/serio1

.config

CONFIG_INPUT=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set

Regards
Anders Fugmann

