Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262866AbSJAW0Y>; Tue, 1 Oct 2002 18:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262874AbSJAWT6>; Tue, 1 Oct 2002 18:19:58 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:36131 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S262868AbSJAWSW>; Tue, 1 Oct 2002 18:18:22 -0400
Message-ID: <3D9A82FB.1000300@hotmail.com>
Date: Tue, 01 Oct 2002 22:24:11 -0700
From: walt <wa1ter@hotmail.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020727
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.40 More on ppa.o (Zip Drive)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm now up and running with 2.5.40, thank you!  No obvious IDE
problems so far--but it's very early yet.

I applied Gert Vervoort's patch to ppa.c which allowed the
compile to finish, but there is still a problem.

When I do a modprobe (or insmod) ppa I get a segfault from
insmod. [version 2.4.19/Debian testing]

The wierd part is that ppa seems to get loaded in spite
of the segfault, and it actually seems to work.  I've
tried only reading the Zip so far--considering the error
message I didn't try writing to it.

A partial listing of the messages I see when loading ppa:

bad: scheduling while atomic! [series of hex numbers]
Call trace: [another series of hex numbers]
[repeat the above two steps]
Unable to handle kernel paging request at ....
[more messages including Oops: 0004]
process insmod exited with preempt_count 1
Segmentation fault.

Unfortunately these errors only print out on a
virtual terminal, not on an xterm, so I have to
copy them by hand.  I can copy them more completely
if it would help.

