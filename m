Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266507AbRGQNbp>; Tue, 17 Jul 2001 09:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266500AbRGQNbf>; Tue, 17 Jul 2001 09:31:35 -0400
Received: from scooter.wvu.edu ([157.182.140.80]:59352 "EHLO scooter.wvu.edu")
	by vger.kernel.org with ESMTP id <S266507AbRGQNbV>;
	Tue, 17 Jul 2001 09:31:21 -0400
Message-ID: <3B543E28.4060303@wvu.edu>
Date: Tue, 17 Jul 2001 09:31:20 -0400
From: David Shepard <dshepard@wvu.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2+) Gecko/20010715
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: CS46XX Module with 2.4.6 kernel on IBM Thinkpad A20m
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CS46XX Module with 2.4.6 kernel on IBM Thinkpad A20m-

The sound on this laptop works inconsistently. lsmod indicates that all 
modules to operate this device are properly loaded(cs46xx, soundcore, 
ac97_codec).  Sound works fine for a given length of time. If you then 
stop listening to say, an .mp3 on xmms,  the program will sometimes 
 exit with what sounds like an audible "spike".  Any attempt to access 
the audio immediately after this will end in failure, with the error 
message "could not connect to device /dev/dsp". However if you wait a 
while, it will work again. Sometimes. I recall this happening with an 
older kernel version a while back as well, except the only way to fix 
this problem back then was to restart the system.  One of the options I 
chose during kernel configuration was "use persistent dma buffers".

Just wondering if anyone knows what causes this.


Thanks,
David Shepard.

