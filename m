Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWDFOeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWDFOeU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 10:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWDFOeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 10:34:20 -0400
Received: from mail.advantech.ca ([207.35.60.239]:56782 "EHLO
	exch2k.Advantech.ca") by vger.kernel.org with ESMTP id S932157AbWDFOeT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 10:34:19 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: [2.6.16 PATCH] Filessytem Events Reporter V2
Date: Thu, 6 Apr 2006 10:34:18 -0400
Message-ID: <1A60C93388AFD3419AEE0E20A116D3201D24D3@exch2k>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6.16 PATCH] Filessytem Events Reporter V2
Thread-Index: AcZZCqzLc5SsfCx4RYK7KoOj/HileQAfBnkw
From: "Michael Guo" <Michael.Guo@advantechAMT.com>
To: "Yi Yang" <yang.y.yi@gmail.com>
Cc: "LKML" <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>,
       "Matt Helsley" <matthltc@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, when kernel developers throw "everything" to libraries and let them encapsulate "everything", it sounds like old story: hardware engineers hope software engineers to do more things, however, software engineers think it reservedly. And for application engineers, it is also unfair because they have to follow new features added by libraries even worse have to update their programs from time to time. Who knows library programmers never change their own interface in order to keep to trace new kernel due to similar functionalities but different interfaces. 

               Kernel size UP -> Library size UP -> Application size UP (chain reaction)
            
I don't know if the time when users complain that their systems are running slowly and slowly and memory is becoming scarce even if fastest CPU (whatever single or multiple cores) and tons of memory is coming very soon. By the way, it is pleasure to discuss the problem with you


-----Original Message-----
From: Yi Yang [mailto:yang.y.yi@gmail.com]
Sent: Wednesday, April 05, 2006 7:44 PM
To: Michael Guo
Cc: LKML; Andrew Morton; Evgeniy Polyakov; Matt Helsley
Subject: Re: [2.6.16 PATCH] Filessytem Events Reporter V2


Michael Guo wrote:
> Hi,
>   Now, kernel is growing bigger and bigger continuously and performance is becoming slower. So, if possible, please consider to add a 
> common and simple interface which is scalable and flexible to satisfy real requirement of users instead of telling users use this or that like Microsoft. In a word, simple makes application programmers happy!
>
>
> Guo
>   
Your requirement should be done by a userspace library, in fact, most of
functions provided by kernel are exported
to the final application in this way
