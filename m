Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270075AbRHNDIN>; Mon, 13 Aug 2001 23:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270115AbRHNDIE>; Mon, 13 Aug 2001 23:08:04 -0400
Received: from gigi.excite.com ([199.172.152.110]:17044 "EHLO gigi.excite.com")
	by vger.kernel.org with ESMTP id <S270075AbRHNDHy>;
	Mon, 13 Aug 2001 23:07:54 -0400
Message-ID: <27661815.997758482137.JavaMail.imail@scorch.excite.com>
Date: Mon, 13 Aug 2001 20:08:01 -0700 (PDT)
From: Parag Warudkar <paragw@excite.com>
Reply-To: <paragw@excite.com>
To: Colonel <klink@clouddancer.com>
Subject: Re:
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: Excite Inbox
X-Sender-Ip: 164.164.130.13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Additionally include/linux/modules/ksyms.ver 
requires following  two lines to be added for modules to work

#define __ver_no_llseek 8d4d42a6 
#define no_llseek       _set_ver(no_llseek)

Parag

On Mon, 13 Aug 2001 08:51:03 -0700 (PDT), Colonel wrote:

>  From: Colonel <klink@clouddancer.com>
>  To: paragw@excite.com
>  In-reply-to: <6558420.997690787827.JavaMail.imail@mayall.excite.com>
(message
>  	from Parag Warudkar on Mon, 13 Aug 2001 01:19:46 -0700 (PDT))
>  Subject: Re: Unresolved symbol: no_llseek
>  Reply-to: klink@clouddancer.com
>  References:  <6558420.997690787827.JavaMail.imail@mayall.excite.com>
>  
>     Date: Mon, 13 Aug 2001 01:19:46 -0700 (PDT)
>     From: Parag Warudkar <paragw@excite.com>
>     Reply-To: paragw@excite.com
>     Content-Type: text/plain; charset=us-ascii
>     X-Sender-Ip: 164.164.130.13
>  
>     Hi,
>  	 May be now you can answer my query :)?
>  
>     TIA,
>  
>     Parag
>  
>  
>  There was a msg posted from me replying to Linus about 15 minutes
>  prior to your query.  There are two missing symbols in kernel/ksyms
>  that need exporting.
>  
>  diff ksyms.c ksyms.c.~1~ 
>  245,246d244
>  < EXPORT_SYMBOL(generic_file_llseek);
>  < EXPORT_SYMBOL(no_llseek);
>  
>  
>  
>  
>  
>     In clouddancer.list.kernel, you wrote:
>  
>     >
>     >
>     >This is a multi-part message in MIME format.
>     >
>     >--------------InterScan_NT_MIME_Boundary
>     >Content-Type: text/plain; charset=us-ascii; format=flowed
>     >Content-Transfer-Encoding: 7bit
>     >
>     >
>     >In i810_audio: Unresolved symbol: no_llseek
>     >
>     >In agpgart : Unresolved symbol: no_llseek
>     >
>     >
>  
>  
>     I think I could tell you the answer, but it might violation this
disclaimer.
>  
>  
>  
>  
>     Parag Warudkar
>     Senior Systems Engineer
>     Wipro Technologies,
>     E-Commerce Division,
>     Lavelle Road,
>     Bangalore - 560001.
>     Ph: 2215010 Ext: 124.
>  
>  
>  
>  
>  
>     _______________________________________________________
>     http://inbox.excite.com
>  
>  


Parag Warudkar
Senior Systems Engineer
Wipro Technologies,
E-Commerce Division,
Lavelle Road,
Bangalore - 560001.
Ph: 2215010 Ext: 124.





_______________________________________________________
Send a cool gift with your E-Card
http://www.bluemountain.com/giftcenter/


