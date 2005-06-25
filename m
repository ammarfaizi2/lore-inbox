Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVFYSni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVFYSni (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 14:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVFYSnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 14:43:37 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:45252
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261247AbVFYSnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 14:43:21 -0400
Message-ID: <42BD9797.4030009@linuxwireless.org>
Date: Sat, 25 Jun 2005 12:42:47 -0500
From: Alejandro Bonilla <abonilla@linuxwireless.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Sladen <thinkpad@paul.sladen.org>
CC: linux-thinkpad@linux-thinkpad.org, Eric Piel <Eric.Piel@tremplin-utc.net>,
       "'Vojtech Pavlik'" <vojtech@suse.cz>, borislav@users.sourceforge.net,
       "'Pavel Machek'" <pavel@ucw.cz>,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [ltp] IBM HDAPS Someone interested? (Accelerometer)
References: <Pine.LNX.4.21.0506250712140.10376-100000@starsky.19inch.net>
In-Reply-To: <Pine.LNX.4.21.0506250712140.10376-100000@starsky.19inch.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Sladen wrote:

>On Thu, 23 Jun 2005, Lee Revell wrote:
>  
>
>>Yup, it's just doing port IO.  Get a kernel debugger for windows like
>>softice and this will be trivial to RE.
>>READ_PORT_USHORT / WRITE_PORT_UCHAR / READ_PORT_UCHAR
>>    
>>
>
>There are 3 ports involved.  The 0xed "non-existant delay port" and a pair
>of ports that are through the Super-I/O / IDE.  They are used in a
>index+value setup similar to reading/writing the AT keyboard controller.
>
>>From what I remember, my conclusion was that these instructions were the
>ones to park the heads and then lock the IDE bus.  It's a couple of months
>ago, but somewhere I have the simplified version of what it was doing...
>
>	-Paul
>  
>
Paul, if you can find that information and Join us into the Project, 
then we will be very happy about it. I hope you still have your 
ThinkPad. ;-)

So, let me get this correct. The Super-I/O only sends the information or 
should we be reading the information of what the accelerometer is 
outputting?

The way I was thinking about it, is that you would only read from the 
accelerometer, and within the value that is read, you will park or not 
the heads depending on how sensitive the user specified the option on 
the driver.

.Alejandro
