Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262054AbVHCFgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262054AbVHCFgs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 01:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbVHCFgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 01:36:48 -0400
Received: from apisx02.abbasiapacific.com.sg ([210.24.147.18]:6667 "EHLO
	apisx02.abbasiapacific.com.sg") by vger.kernel.org with ESMTP
	id S262054AbVHCFgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 01:36:48 -0400
Sensitivity: 
Subject: Re: Sandisk Compact Flash
To: dhinds@sonic.net
Cc: somshekar.c.kadam@in.abb.com, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OF595E5A9B.8FE85EE2-ON65257052.001EE25F-65257052.001EE28F@abbasiapacific.com.sg>
From: somshekar.c.kadam@in.abb.com
Date: Wed, 3 Aug 2005 11:07:37 +0530
X-MIMETrack: Serialize by Router on ABB_APEXTERNAL_WWW01/APEXTERNAL(Release 5.0.12  |February
 13, 2003) at 08/03/2005 01:37:09 PM
MIME-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=C7BBFAC1DF8CAEE88f9e8a93df938690918cC7BBFAC1DF8CAEE8"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=C7BBFAC1DF8CAEE88f9e8a93df938690918cC7BBFAC1DF8CAEE8
Content-type: text/plain; charset=us-ascii





HI David ,

Thanks a Lot for clearing all the doubts , yes its the drawback of my
hardware which i cant use high speed compact flash as DMA is not supported
,

Is there anyway with the help of software to message that , this compact
flash cant be used anymore , first of all is this a good idea to have such
a functinality on embedded system of saying compact flash is going to die
please replace it , or just by the number of years of compact flash we say
replace the compact flash

Thanks In Advance
Somshekar


                                                                                                     
 (Embedded     David Hinds <dhinds@sonic.net>                                                        
 image moved   07/20/2005 09:56 PM                                                                   
 to file:                                                                                            
 pic18875.pcx)                                                                                       
                                                                                                     
                                                                                                     



To:    somshekar.c.kadam@in.abb.com
cc:    linux-kernel@vger.kernel.org
Subject:    Re: Sandisk Compact Flash

Security Level:?              Internal

On Wed, Jul 20, 2005 at 12:49:00PM +0530, somshekar.c.kadam@in.abb.com
wrote:
>
> Hi David ,
>
> On my controller CF INPACK pin is connected to 3.3v.  so Comapct
> flash with DMA capabilty will not be supported , i understood this .
> but i did not undesrtand why only PIO mode 1 is supported is it ,
> why not PIO mode 4 , is it a limitation of pcmcia driver , correct
> me if i am wrong

The 16-bit PCMCIA bus is maxed out at about 1 MB/sec; that's all the
bandwidth there is.  What your card supports is irrelevant.

I'm not sure whether the PCMCIA mode actually corresponds to any of
the official PIO modes 0, 1, etc.  It is just "slow".

-- Dave





--0__=C7BBFAC1DF8CAEE88f9e8a93df938690918cC7BBFAC1DF8CAEE8
Content-type: application/octet-stream; 
	name="pic18875.pcx"
Content-Disposition: attachment; filename="pic18875.pcx"
Content-transfer-encoding: base64

CgUBCAAAAABBADEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAABQgABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAA=

--0__=C7BBFAC1DF8CAEE88f9e8a93df938690918cC7BBFAC1DF8CAEE8--

