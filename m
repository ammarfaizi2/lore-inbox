Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbVHWLKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbVHWLKH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 07:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbVHWLKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 07:10:07 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:48617 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932119AbVHWLKG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 07:10:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=jOAG9MnWYTJe+TBTNlZ43sRJrDUxSuxcQU3XPz936fKk+ok/IHLO/YupvJl8spxahjoO71sRGzicdTKFzmVL2uIAF1KRs2pScdHt5e6vAuGepODTg0XMx/1k04Mdsiu/dv4OsOFHiqf/I/Lw8pOi1m3PeB7LfcTq9on2yH/vfWw=
Message-ID: <430B03B4.8040205@gmail.com>
Date: Tue, 23 Aug 2005 16:38:36 +0530
From: Rajesh <rvarada@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: debug a high load average
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:

I have a case occasionally when I copy data from a usb storage (ipod) to 
my hard drive the load average goes up from 0.4 to about 15.0, and the 
system becomes very unusable till I kill the cp command. I have checked 
the CPU usage, bytes read from usb device, byte written to hard drive 
etc, and all these values are low like CPU usage is at a maximum of 30%, 
disk read bytes is at an average of 1.5 MiB/s, disk write bytes is at 
1.5 MiB/s, number of processes is at 110, etc, during this high load.

So my question is what else determines the high load average that in 
turn is resulting in the unresponsiveness of the system? What else 
should I be looking for to debug the problem?

Thanks a lot,
Rajesh

