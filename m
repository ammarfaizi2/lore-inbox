Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313471AbSDGUzo>; Sun, 7 Apr 2002 16:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313472AbSDGUzn>; Sun, 7 Apr 2002 16:55:43 -0400
Received: from smtp.localnet.com ([207.251.201.46]:19353 "HELO
	smtp.localnet.com") by vger.kernel.org with SMTP id <S313471AbSDGUzm>;
	Sun, 7 Apr 2002 16:55:42 -0400
To: Urban Widmark <urban@teststation.com>
Cc: Keith Owens <kaos@ocs.com.au>, <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [patch] Re: 2.4.19-pre6 dead Makefile entries
In-Reply-To: <Pine.LNX.4.33.0204071541030.4531-100000@cola.teststation.com>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
Date: 07 Apr 2002 16:55:27 -0400
Message-ID: <m3elhrjkjk.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> fs/nls/Makefile nls_cp1252.o

It does seem as though this one would be useful to a significant
number of people.  Is there some reason 125[2-46-8] are not included
where the rest are?  

I can generate a patch to add the missing ones if anyone is
interested.  Though it would be easier were there a tool to automate
those .c files....  (I've not found any docs about the layout; I'm
sure it would be easy given such info to modify eg Markus Kuhn's
uniset to output the necessary data.  In fact, it seems like it would
be better to include the unicode table files in the kernel tree and
use a utility to generate the nls...c files as needed, yes?)

-JimC

