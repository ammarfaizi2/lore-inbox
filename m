Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264924AbUD2Suk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264924AbUD2Suk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 14:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264921AbUD2Suk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 14:50:40 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:11490 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264924AbUD2St3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 14:49:29 -0400
In-Reply-To: <20040429031040.GA5336@kroah.com>
References: <20040428181806.GA36322@atlantis.8hz.com> <80928E9A-9983-11D8-9ADE-000A95B17CC2@comcast.net> <20040429031040.GA5336@kroah.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <EF9BE23E-9A0D-11D8-B72E-000A95B17CC2@comcast.net>
Content-Transfer-Encoding: 7bit
Cc: Sean Young <sean@mess.org>, Chester <fitchett@phidgets.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
From: Bryan Small <code_smith@comcast.net>
Subject: Re: [PATCH] USB: add new USB PhidgetServo driver
Date: Thu, 29 Apr 2004 14:49:25 -0400
To: Greg KH <greg@kroah.com>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The IFkit ( both 8/8/8 and 0/8/8) and the TextLCD will work nearly the 
same as Sean's servo control. They will use sysfs also. They will be 
blacklisted from HID. Sean, what phidget did you want to work on next. 
I just wanted to make sure, I was not stepping on others toes by 
jumping on the ones I picked. If you want Chester can just make us a 
big ol punchlist and we can just start knocking them out. I have most 
of the phidgets except the stepper controller, power bar, dc 
controller, and the new 0/16/16. I think thats correct, right 
Chester..?

And yay I finally got my linux dev. box back from dead. I was beginning 
to worry, I was not going to be able to do anything, and Sean would 
have finished it all. :-) But hopefully by tonight I will have 
everything ready to go.


Bryan Small

On Apr 28, 2004, at 11:10 PM, Greg KH wrote:

> On Wed, Apr 28, 2004 at 10:18:28PM -0400, Bryan Small wrote:
>>   Really cool Sean. I am currently working on the IfKit for both the
>> 8/8/8 and the 0/8/8 on the textlcds. Also working on the textlcds
>> output.
>
> What kernel/userspace interface were you going to use?  Or are you 
> using
> a pure libusb/usbfs type interface?
>
>> If I get these done soon was thinking of moving to RFID, so that we 
>> can
>> also possibly throw in Chesters PAM auth module idea in.
>
> That is a cool project, again, what kind of kernel interaction would 
> you
> want for it?
>
> thanks,
>
> greg k-h
>

