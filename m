Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290683AbSARMl0>; Fri, 18 Jan 2002 07:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290684AbSARMlP>; Fri, 18 Jan 2002 07:41:15 -0500
Received: from mail.cert.uni-stuttgart.de ([129.69.16.17]:11447 "HELO
	Mail.CERT.Uni-Stuttgart.DE") by vger.kernel.org with SMTP
	id <S290683AbSARMlE>; Fri, 18 Jan 2002 07:41:04 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Hardwired drivers are going away?
In-Reply-To: <Pine.LNX.4.44.0201141358060.3238-100000@filesrv1.baby-dragons.com>
From: Florian Weimer <Weimer@CERT.Uni-Stuttgart.DE>
Date: Fri, 18 Jan 2002 13:39:01 +0100
In-Reply-To: <Pine.LNX.4.44.0201141358060.3238-100000@filesrv1.baby-dragons.com> ("Mr.
 James W. Laferriere"'s message of "Mon, 14 Jan 2002 14:00:01 -0500 (EST)")
Message-ID: <87sn93zvdm.fsf@CERT.Uni-Stuttgart.DE>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.1 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mr. James W. Laferriere" <babydr@baby-dragons.com> writes:

> 	Hello Alan ,
>
> On Mon, 14 Jan 2002, Alan Cox wrote:
>> > 1. security, if you don't need any modules you can disable modules entirly
>> > and then it's impossible to add a module without patching the kernel first
>> > (the module load system calls aren't there)
>>
>> Urban legend.
> 	I do not agree .  Got proof ?  Yes that is a valid question .

http://www.phrack.org/phrack/58/p58-0x07

Globally preloading a shared library in user space is almost as
effective, BTW, unless your critical binaries are linked statically
(which is unusual on most systems nowadays).

-- 
Florian Weimer 	                  Weimer@CERT.Uni-Stuttgart.DE
University of Stuttgart           http://CERT.Uni-Stuttgart.DE/people/fw/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
