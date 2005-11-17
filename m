Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161130AbVKQEby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161130AbVKQEby (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 23:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161131AbVKQEby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 23:31:54 -0500
Received: from c-67-177-35-222.hsd1.ut.comcast.net ([67.177.35.222]:14976 "EHLO
	vger.utah-nac.org") by vger.kernel.org with ESMTP id S1161130AbVKQEbx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 23:31:53 -0500
Message-ID: <437C0189.8000204@wolfmountaingroup.com>
Date: Wed, 16 Nov 2005 21:05:29 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: =?UTF-8?B?SsO2cm4gRW5nZWw=?= <joern@wohnheim.fh-wedel.de>,
       Andi Kleen <ak@suse.de>, Arjan van de Ven <arjan@infradead.org>,
       Oliver Neukum <oliver@neukum.org>, jmerkey <jmerkey@utah-nac.org>,
       alex14641@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
References: <20051116005034.73421.qmail@web50210.mail.yahoo.com> <200511161630.59588.oliver@neukum.org> <1132155482.2834.42.camel@laptopd505.fenrus.org> <200511161710.05526.ak@suse.de> <20051116184508.GP5735@stusta.de> <20051117000654.GA11128@wohnheim.fh-wedel.de> <437BB7D1.2090109@wolfmountaingroup.com> <437BB8A3.9030701@wolfmountaingroup.com> <20051117003115.GT5735@stusta.de>
In-Reply-To: <20051117003115.GT5735@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>On Wed, Nov 16, 2005 at 03:54:27PM -0700, Jeffrey V. Merkey wrote:
>  
>
>>>The SCSI layer needs to be checked.  I reproduced another crash on 
>>>today on an older Niksun box running off the end of the stack.
>>>
>>>Jeff
>>>
>>>
>>>      
>>>
>>It's somewhere in the scanning code.  There's a case where it runs off 
>>the end of the stack.  Check the compaq drivers for SATA as well, they 
>>also crash in a similiar place during bus scan.  Both occurred during 
>>bootup, so I wasn't able to get a log of the particulars.  Should be 
>>easy to reproduce.  Compaq Presario 2200.
>>    
>>
>
>Are you using completely unmodified ftp.kernel.org kernels?.
>  
>

Yes.

>Which version?
>
>  
>
2.6.14

>If it occurs during bootup, you should see the error displayed.
>Please use a digital camera to photograph the error and send a linkt ot 
>the photo.
>
>  
>
The error is a stack trace rolling off the screen with a list of 
functions -- right before it reboots.

Jeff

>>Jeff
>>    
>>
>
>cu
>Adrian
>
>  
>

