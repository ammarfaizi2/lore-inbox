Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317665AbSGLEoV>; Fri, 12 Jul 2002 00:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317670AbSGLEoU>; Fri, 12 Jul 2002 00:44:20 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12043 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317665AbSGLEoT>; Fri, 12 Jul 2002 00:44:19 -0400
Message-ID: <3D2E5F40.9050202@zytor.com>
Date: Thu, 11 Jul 2002 21:46:56 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020524
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: andersen@codepoet.org
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
References: <agl7ov$p91$1@cesium.transmeta.com> <20020712041320.GA2046@codepoet.org> <3D2E585F.2010302@zytor.com> <20020712044413.GA2436@codepoet.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:
>>
>>Lovely.  Let's make EACH APPLICATION support two disjoint APIs for no 
>>good reason.
> 
> Lovely.  Lets rip off a sarcastic answer without spending two
> seconds to think.  Why would anybody need to support two APIs?  
> The existing CDROM_SEND_PACKET ioctl is an ATAPI/SCSI pass
> through interface, and is sufficient to operate both IDE and 
> SCSI cd writers.
> 

That's fine, but it still only supports CD writers.  We have a generic 
packet interface for a good reason -- we should be able to access it 
regardless of device type.

It's a specific solution to a generic problem.

	-hpa


