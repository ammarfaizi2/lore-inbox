Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269453AbTGJRAR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 13:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269450AbTGJQ7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 12:59:46 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:58885 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S269432AbTGJQ7B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 12:59:01 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.5.74 CONFIG_USB_SERIAL_CONSOLE gone?
Date: Fri, 11 Jul 2003 01:13:34 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200307101453.57857.mflt1@micrologica.com.hk> <20030710164121.GA12055@kroah.com>
In-Reply-To: <20030710164121.GA12055@kroah.com>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307110113.34362.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 July 2003 00:41, Greg KH wrote:
> On Thu, Jul 10, 2003 at 02:53:57PM +0800, Michael Frank wrote:
> > Tried to config usb serial console on 2.5.74 but it's no more
> > configurable.
> >
> > Searched the tree and these are the only references
>
> CONFIG_USB has to be set to Y and CONFIG_USB_SERIAL has to be set to Y
> to be able to select this config option.
>
> Do you have those options selected?
>
> And do you _really_ want to use CONFIG_USB_SERIAL_CONSOLE?  It's pretty
> useless for the most part :)
>
> thanks,
>
> greg k-h

I don not want to use it but I have no time to key in oopses ;) 

With reference to my post just sent, I guess you are right, so please lets make it useful

Regards
Michael

-- 
Powered by linux-2.5.74-mm3. Compiled with gcc-2.95-3 - mature and rock solid

My current linux related activities:
- 2.5 yenta_socket testing
- Test development and testing of swsusp for 2.4/2.5 and ACPI S3 of 2.5 kernel 
- Everyday usage of 2.5 kernel

More info on 2.5 kernel: http://www.codemonkey.org.uk/post-halloween-2.5.txt
More info on swsusp: http://sourceforge.net/projects/swsusp/

