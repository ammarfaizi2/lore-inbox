Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263062AbVFWUY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbVFWUY0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 16:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263065AbVFWUYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 16:24:07 -0400
Received: from reserv6.univ-lille1.fr ([193.49.225.20]:34264 "EHLO
	reserv6.univ-lille1.fr") by vger.kernel.org with ESMTP
	id S263062AbVFWUW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 16:22:29 -0400
Message-ID: <42BB19EB.1060202@tremplin-utc.net>
Date: Thu, 23 Jun 2005 22:22:03 +0200
From: Eric Piel <Eric.Piel@tremplin-utc.net>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: abonilla@linuxwireless.org
CC: "'Eric Piel'" <Eric.Piel@tremplin-utc.net>,
       "'Vojtech Pavlik'" <vojtech@suse.cz>, borislav@users.sourceforge.net,
       "'Pavel Machek'" <pavel@ucw.cz>, "'Lee Revell'" <rlrevell@joe-job.com>,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>,
       linux-thinkpad@linux-thinkpad.org, linux-kernel@vger.kernel.org,
       notlug@paul.sladen.org
Subject: Re: [ltp] Re: IBM HDAPS Someone interested?
References: <004001c577f2$865ab650$600cc60a@amer.sykes.com>
In-Reply-To: <004001c577f2$865ab650$600cc60a@amer.sykes.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-USTL-MailScanner-Information: Please contact the ISP for more information
X-USTL-MailScanner: Found to be clean
X-MailScanner-From: eric.piel@tremplin-utc.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

06/23/2005 02:53 PM, Alejandro Bonilla wrote/a écrit:
>   
>>Well, in the changelog of the embedded controller firmware 
>>(ftp://ftp.software.ibm.com/pc/pccbbs/mobiles/1uhj07us.txt) there is:
>>- (New) Support for IBM Hard Disk Active Protection System.
>>
>>I would conclude that the embedded controller is involved 
>>with the HDAPS!
>>
>>Just my two cents.
>>
>>Eric
>>
> 
> OK, awesome. This gives us pretty much a where to go from now.
> 
> Should the IBM-ACPI project have anything to do with this? I mean, we should, or could be getting more -vvv information from ecdump or the fact that because this is attached to the embedded controller makes things harder?
> 
Just to add a few more cents, googling around I found that Paul Sladen 
has already been looking for some info on the chip. Started to RE the 
windows driver, this kind of info _might_ be useful :
Windows drivers read in 28-bytes via an IOCTL(0x733fc) on "\ShockMgr" . 
  (See shockprf.sys)

http://www.paul.sladen.org/thinkpad-r31/accelerometer.html
http://www.paul.sladen.org/thinkpad-r31/aps/

Eric (who is looking forward playing Neverball the Right Way (tm) ;-) )


PS: I don't know Paul Sladen's address and couldn't find it on his 
webpage. Hopping this email address will do it anyway.
