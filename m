Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270087AbRHQKN1>; Fri, 17 Aug 2001 06:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270067AbRHQKNS>; Fri, 17 Aug 2001 06:13:18 -0400
Received: from ny.sm.luth.se ([130.240.3.1]:65526 "EHLO sm.luth.se")
	by vger.kernel.org with ESMTP id <S270050AbRHQKNH>;
	Fri, 17 Aug 2001 06:13:07 -0400
Message-ID: <3B7CEE40.90100@cdt.luth.se>
Date: Fri, 17 Aug 2001 12:13:20 +0200
From: James Nord <teilo@cdt.luth.se>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-gb, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: K6 sig11 Bug detection.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a Debian based system with a custom 2.4.7 kernel compiled with 
gcc version 2.95.4 20010703 (Debian prerelease)
(also saw the same with 2.2.10+ gcc 2.95)

The CPU in the machine is a AMD K6 200MHz, and has 64MB of SDRAM

I reomved the heatsink and the serial is Cxxxxxxxx, however in the 
kernel boot messages I get the following,

Aug 17 09:06:49 phoenix kernel: CPU: Before vendor init, caps: 008001bf 
008005bf 00000000, vendor = 2
Aug 17 09:06:49 phoenix kernel: AMD K6 stepping B detected - <6>K6 BUG 
9016725 20000000 (Report these if test report is incorrect)
Aug 17 09:06:49 phoenix kernel: AMD K6 stepping B detected - probably OK 
(after B9730xxxx).
Aug 17 09:06:49 phoenix kernel: Please see 
http://www.mygale.com/~poulot/k6bug.html
Aug 17 09:06:49 phoenix kernel: CPU: L1 I Cache: 32K (32 bytes/line), D 
cache 32K (32 bytes/line)
Aug 17 09:06:49 phoenix kernel: CPU: After vendor init, caps: 008001bf 
008005bf 00000000 00000000
Aug 17 09:06:49 phoenix kernel: CPU:     After generic, caps: 008001bf 
008005bf 00000000 00000000
Aug 17 09:06:49 phoenix kernel: CPU:             Common caps: 008001bf 
008005bf 00000000 00000000
Aug 17 09:06:49 phoenix kernel: CPU: AMD-K6tm w/ multimedia extensions 
stepping 01

Is the stepping not the first part of the serial? I have 64MB (the 
amount that triggers the bug IIRC) in the system and the the kernel and 
everything else compiles without generating a SIG11.

Is this a false detection or would it be possible that I have a wrongly 
tagged CPU?

Also the link http://www.mygale.com/~poulot/k6bug.html does not exist.

Please CC replies to me as I am not on the list.

Regards,

    /James

-- 
Technology is a word that describes something that doesn't work yet.
	Douglas Adams



