Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293585AbSBZMBk>; Tue, 26 Feb 2002 07:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293589AbSBZMBU>; Tue, 26 Feb 2002 07:01:20 -0500
Received: from sleet.ispgateway.de ([62.67.200.125]:28386 "HELO
	sleet.ispgateway.de") by vger.kernel.org with SMTP
	id <S293585AbSBZMBQ>; Tue, 26 Feb 2002 07:01:16 -0500
Message-ID: <3C7B7908.1040508@ellinger.de>
Date: Tue, 26 Feb 2002 13:01:12 +0100
From: Rainer Ellinger <rainer@ellinger.de>
Organization: Rainers Rechenzentrum
User-Agent: Mozilla/5.0
X-Accept-Language: en
MIME-Version: 1.0
To: Barubary <barubary@cox.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: ISO9660 bug and loopback driver bug
In-Reply-To: <006001c1beb9$ea412690$a7eb0544@CX535256D>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Barubary wrote:

> Now the loopback bug.  Files whose size is greater than 2^31-1 don't work
> with the loopback driver.

Can't reproduce. I can mount 4.7GB DVD-Images and i'm currently working with an 48GB File mounted via loop, and a 100GB partition 
mounted via loop. I'm using loop-AES encryption patch with 2.4.17/18-rc4. I'm not aware if there's a fix in this patch. afaik it 
should also work with vanilla loop.c.

-- 
rainer@ellinger.de

