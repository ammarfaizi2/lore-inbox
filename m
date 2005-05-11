Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbVEKRfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbVEKRfd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 13:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbVEKRfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 13:35:32 -0400
Received: from lantana.tenet.res.in ([202.144.28.166]:28627 "EHLO
	lantana.cs.iitm.ernet.in") by vger.kernel.org with ESMTP
	id S261914AbVEKRee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 13:34:34 -0400
Date: Wed, 11 May 2005 23:04:49 +0530 (IST)
From: "P.Manohar" <pmanohar@lantana.cs.iitm.ernet.in>
To: Marcel Holtmann <marcel@holtmann.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: ioctl to keyboard device file
In-Reply-To: <1115831651.23458.74.camel@pegasus>
Message-ID: <Pine.LNX.4.60.0505112301350.31722@lantana.cs.iitm.ernet.in>
References: <Pine.LNX.4.60.0505112207300.21632@lantana.cs.iitm.ernet.in>
 <1115831651.23458.74.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Mail-scanner Found to be clean
X-MailScanner-From: pmanohar@lantana.cs.iitm.ernet.in
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

n Wed, 11 May 2005, Marcel Holtmann wrote:
> Hi,
>
>>       I want to add a new ioctl to keyboard driver device file which will
>> perform the work of copying user space data  sent to it into kernel
>> space and send those characters  to handle_scancode function of keyboard
>> driver.. Now I want to know
>>
>> 1) what is the device file corresponding to keyboard (is it
>> /dev/input/keyboard).
>> 2) where file operations structure is defined for that.
>> 3) where the those ioctls handled(not found in keyboard.c).
>>
>> Any small help is appreciated.
>
> why not using uinput for this job?

Hai,
   Thanks for the solution.  I did the above task, by defining a new
character device driver and sending ioctl to it. and calling
handle_scancode from it. Now I want
to do the same task with in the keyboard driver. For that I need to send
ioctl to keyboard device file.
For that only I asked the
above doubts.

regards,
P.Manohar.
