Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262242AbUKKO5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbUKKO5J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 09:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbUKKO5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 09:57:09 -0500
Received: from bay2-f31.bay2.hotmail.com ([65.54.247.31]:29083 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262242AbUKKO5G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 09:57:06 -0500
X-Originating-IP: [203.129.224.106]
X-Originating-Email: [siddheish@hotmail.com]
From: "Siddhesh Bhadkamkar" <siddheish@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.26 IDE driver
Date: Thu, 11 Nov 2004 14:56:21 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY2-F311s7nlT2NqFJ0002718f@hotmail.com>
X-OriginalArrivalTime: 11 Nov 2004 14:57:02.0012 (UTC) FILETIME=[B37C87C0:01C4C7FE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we are trying to modify IDE driver as a possible workaround for an 
unreliable storage media.

this driver will expose only a part of the disk to file system by reporting 
the disk capacity as say real_capacity/4. remaining disk will be hidden from 
the file system. in write operation driver will try to write the same data 
in all 4 parts of the same disk for redundancy. in read it will hope to find 
atleast one copy properly written.

we are using kernel version 2.4.26. what approach do you think would be 
appropriate?

Thanks,
Siddhesh

_________________________________________________________________
The all-new MSN Mesenger! Get the coolest emoticons. 
http://server1.msn.co.in/sp04/messengerchat/ Share more of yourself!

