Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313037AbSC0PzN>; Wed, 27 Mar 2002 10:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313039AbSC0PzD>; Wed, 27 Mar 2002 10:55:03 -0500
Received: from web14901.mail.yahoo.com ([216.136.225.53]:58658 "HELO
	web14901.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S313037AbSC0Pyx>; Wed, 27 Mar 2002 10:54:53 -0500
Message-ID: <20020327155452.96224.qmail@web14901.mail.yahoo.com>
Date: Wed, 27 Mar 2002 10:54:52 -0500 (EST)
From: Michael Zhu <mylinuxk@yahoo.ca>
Subject: Confliction between my device and printer
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, everyone, I developed a character device which
is plugged into the parallel port of computer. A
printer can be connected at the rear of this device.
That means that all the printing information will pass
through my device. When my device and the printer work
at the same time the two devices affect with each
other. Both devices work innormally. There is some
kind of confliction. I know the exact reason. In my
device driver I just simply send and read the data
from my device directly without checking whether the
parallel port resource is available. That is a
problem. Now I am just wondering in Linux how can I
check whether the parallel port resource is avaliable.
I need to add that kind of code to my device driver.
Thank you very much.



______________________________________________________________________ 
File your taxes online! http://taxes.yahoo.ca
