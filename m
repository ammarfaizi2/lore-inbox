Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264376AbRGEVmV>; Thu, 5 Jul 2001 17:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264381AbRGEVmL>; Thu, 5 Jul 2001 17:42:11 -0400
Received: from sncgw.nai.com ([161.69.248.229]:54225 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S264376AbRGEVmB>;
	Thu, 5 Jul 2001 17:42:01 -0400
Message-ID: <XFMail.20010705144521.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <8505.994368672@redhat.com>
Date: Thu, 05 Jul 2001 14:45:21 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: linux/macros.h(new) and linux/list.h(mod) ...
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05-Jul-2001 David Woodhouse wrote:
> 
> davidel@xmailserver.org said:
>> This patch add a new linux/macros.h that is supposed to host utility
>> macros that otherwise developers are forced to define in their files.
>> This version contain only min(), max() and abs(). 
> 
> Consider min(x++,y++). Try:
> 
>#define min(x,y) ({ typeof((x)) _x = (x); typeof((y)) _y = (y); (_x>_y)?_y:_x;
>#})
>#define max(x,y) ({ typeof((x)) _x = (x); typeof((y)) _y = (y); (_x>_y)?_x:_y;
>#})

Yep, it's better.




- Davide

