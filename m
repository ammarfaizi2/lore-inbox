Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316210AbSE3CnX>; Wed, 29 May 2002 22:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316214AbSE3CnW>; Wed, 29 May 2002 22:43:22 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:61195 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S316210AbSE3CnW>;
	Wed, 29 May 2002 22:43:22 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200205300243.g4U2hIZ369399@saturn.cs.uml.edu>
Subject: Re: [PATCH] intel-x86 model config cleanup
To: davej@suse.de (Dave Jones)
Date: Wed, 29 May 2002 22:43:18 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        jamagallon@able.es (J.A. Magallon),
        linux-kernel@vger.kernel.org (Lista Linux-Kernel),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <20020530021159.B26821@suse.de> from "Dave Jones" at May 30, 2002 02:11:59 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones writes:
> On Wed, May 29, 2002 at 06:05:40PM -0400, Albert D. Cahalan wrote:

>> This is still a mess. It's better to have one boolean
>> per processor, and order the processors by the year
>> in which they were most commonly sold.
>
> The information hiding of irrelevant options was one of the
> motivations behind that original patch. If I know I have
> an AMD Athlon, showing me all the Intel CPUs just gets in the way.

No, it's like this:

I want one kernel. I have a Pentium-MMX and a Pentium Pro.
I don't need support for a 386, 486, Athlon, or Xeon.

It's also like this:

We have a lab full of Athlon and Pentium III boxes.
There's not a Pentium 4 in sight, and no Pentium II
either. It's too much work to manage multiple kernels;
every box must boot from the same disk image.
