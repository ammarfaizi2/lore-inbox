Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137175AbREKRDB>; Fri, 11 May 2001 13:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137176AbREKRCw>; Fri, 11 May 2001 13:02:52 -0400
Received: from web13405.mail.yahoo.com ([216.136.175.63]:2323 "HELO
	web13405.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S137175AbREKRCp>; Fri, 11 May 2001 13:02:45 -0400
Message-ID: <20010511170244.71793.qmail@web13405.mail.yahoo.com>
Date: Fri, 11 May 2001 10:02:44 -0700 (PDT)
From: mohan kumar <mohan_linux@yahoo.com>
Subject: kernel to user space transactions
To: linux-kernel@vger.kernel.org
Cc: lug@lug.boulder.co.us
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
we are developing a protocol analyser. our application
needs to capture 100 mbps full duplex traffic. we have
the application in windows which does the same. we are
now trying to port it to linux. we came up with a
basic application that captures traffic. iam very
happy to say that linux was able to capture 100 mbps
full duplex traffic more ( a lot of mores :-) to be
correct) efficiantly than windows. now that we are
ready to port the application to linux, we are trying
to find the best way to transfer data to the user
space from kernel space. we tried normal blocking read
and it works fine. but we dont want to waste cycle on
transfering data to and fro kernel and user land. so
we tried some other techniques like remaping the
kernel land buffers to userland via mmap. that also
works fine. 

now we have a doubt that, like maping kernal space
buffers to user space, weather we will be able to map
user space buffers to kernel space(so that we can
write data directly from packet capture
function(registered via dev_add_pack))

so can u guys point out weather that kind of approach
will work and if so where do i start looking?.

thanx,
Mohan Kumar S
Amoeba Telecom
(visit us at www.amoebatel.com)



__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - buy the things you want at great prices
http://auctions.yahoo.com/
