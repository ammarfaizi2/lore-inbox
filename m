Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265650AbSJSSio>; Sat, 19 Oct 2002 14:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265652AbSJSSio>; Sat, 19 Oct 2002 14:38:44 -0400
Received: from mail.powweb.com ([63.251.213.34]:57060 "EHLO mail.powweb.com")
	by vger.kernel.org with ESMTP id <S265650AbSJSSio> convert rfc822-to-8bit;
	Sat, 19 Oct 2002 14:38:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Mark Gross <markgross@thegnar.org>
Organization: thegnar
To: phil-list@redhat.com, Mark Kettenis <kettenis@chello.nl>, dan@debian.org,
       mingo@elte.hu
Subject: Re: [patch] thread-aware coredumps, 2.5.43-C3
Date: Sat, 19 Oct 2002 11:42:51 -0700
User-Agent: KMail/1.4.3
Cc: mgross@unix-os.sc.intel.com, linux-kernel@vger.kernel.org,
       phil-list@redhat.com
References: <Pine.LNX.4.44.0210171009240.12653-100000@localhost.localdomain> <20021018004847.GA27817@nevyn.them.org> <200210191320.g9JDKJWs001201@elgar.kettenis.dyndns.org>
In-Reply-To: <200210191320.g9JDKJWs001201@elgar.kettenis.dyndns.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210191142.51364.markgross@thegnar.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 October 2002 06:20 am, Mark Kettenis wrote:
> Therefore, I don't think we should "contaminate" our source with
> backwards compatibility hacks.  

I agree, lets get the kernel and gdb to match up as soon as possible.  

When do you think GDB get these 2 changes (section ID for extended floating 
point sections and that namesz == 5 test) in?

< snip > 

>
> In the light of the discussion above, I don't think Ingo's patch
> should change NT_FPXREG/NT_PRFPXREG from 20 to 0x46e62b7f (and the
> name shouldn't be changed either I think).  We should change it in
> GDB/BFD instead from 0x46e62b7f.  The value 20 is already publically
> available in the current kernel headers and glibc headers.  What are
> your feelings about that, Ingo?

--mgross

