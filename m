Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313694AbSDFDm0>; Fri, 5 Apr 2002 22:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313695AbSDFDmH>; Fri, 5 Apr 2002 22:42:07 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:59909 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S313694AbSDFDl4>;
	Fri, 5 Apr 2002 22:41:56 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanup KERNEL_VERSION definition and linux/version.h 
In-Reply-To: Your message of "Fri, 05 Apr 2002 09:55:27 PST."
             <20020405175527.GK961@matchmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 06 Apr 2002 13:41:46 +1000
Message-ID: <14688.1018064506@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Apr 2002 09:55:27 -0800, 
Mike Fedyk <mfedyk@matchmail.com> wrote:
>> >On Thu, Apr 04, 2002 at 11:36:06AM +1000, Keith Owens wrote:
>> Breaking that chain _might_ cause problems in 2.4 because it does not
>> have a complete dependency chain to pick up changes to the top level
>> Makefile, it only works at the moment due to the extra recompiles.  I
>> am not willing to change this in 2.4 until I have got it stable in 2.5.
>
>Hmm.  It looks like kbuild 2.5 might be able to be split up into a few
>separate parts.  Do you think so too?

There are some bug fixes to existing makefiles and CML1 that can safely
be fed back to 2.4, I will do them next week.  Apart from that, the
design philosophies for kbuild 2.4 and 2.5 are completely different,
there is little from kbuild 2.5 that can safely be extracted and back
ported to kbuild 2.4.

>Do you know where I could find some good documentation on Makefiles?
>Especially on dependencies and etc?

info make.

