Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267027AbRGJUkA>; Tue, 10 Jul 2001 16:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267140AbRGJUjs>; Tue, 10 Jul 2001 16:39:48 -0400
Received: from woodyjr.wcnet.org ([63.174.200.2]:17832 "EHLO woodyjr.wcnet.org")
	by vger.kernel.org with ESMTP id <S267027AbRGJUjc>;
	Tue, 10 Jul 2001 16:39:32 -0400
Message-ID: <001501c10980$f42035a0$fe00000a@cslater>
From: "C. Slater" <cslater@wcnet.org>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <NOEJJDACGOHCKNCOGFOMOEKECGAA.davids@webmaster.com>
Subject: Re: Switching Kernels without Rebooting?
Date: Tue, 10 Jul 2001 16:43:18 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>
> >     - Replace all saved structures
>
> > what if the layout of these changes as it often does?
>
> You would want to convert all structures into a neutral encoding scheme
> that would support transferring structures across versions. BER comes to
> mind, as it provides for an easy way to ignore stuff you don't understand
> and support multiple versions of the same object in a single encoding.
>
> However, this would be a truly massive task. And the big challenge would
be
> what to do when an older kernel doesn't understand something essential. It
> could be simplified significantly by supporting live replacement only of
> kernels of the same version, but this seems to defeat much of the purpose.
>
> DS

I don't think that it would be possible to switch kernels when one was not
properly set up to do it, if thats what you mean. You could only switch
between kernels that have been compiled to support live switching.

I do see you'r point with the datastructures changeing. We would need to use
some format that all properly setup kernels could understand, then we would
only need to write enough to convert the structs to the middle format and
back when they change. I am not familer with BER, but if it is suitable, it
may help.

Are you saying that swaping the kernels out altogether would be a massive
task, or that saveing/restoring the datastructures would be a massive task.

  Colin

