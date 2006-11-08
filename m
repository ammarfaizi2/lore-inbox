Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161334AbWKHX2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161334AbWKHX2Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 18:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754673AbWKHX2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 18:28:24 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:19436 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1754670AbWKHX2X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 18:28:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=BzCGnekO1wop004ZHkuVk7kT9HpxNd5+kVB4tGK3NfdtR9Xlky+M5YPK9pSulxYPN8XM58AWY4z6v117DfTLfng687buKEmofB+Dwg6K4wpU2MwOhCW0pV5NMyt2JKWN7/3v1ns0qy7PpcZuGPfU4YpvWGg/6mqX4OGXnyEjwvg=
Date: Thu, 9 Nov 2006 00:28:02 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: A proposal; making 2.6.20 a bugfix only version.
Message-Id: <20061109002802.f61804fa.diegocg@gmail.com>
In-Reply-To: <1163024531.3138.406.camel@laptopd505.fenrus.org>
References: <9a8748490611081409x6b4cc4b4lc52b91c7b7b237a6@mail.gmail.com>
	<1163024531.3138.406.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 08 Nov 2006 23:22:11 +0100,
Arjan van de Ven <arjan@infradead.org> escribió:

> > There are many parts of the kernel that are not documented.
> 
> this is where the OSDL Documentation Person will help a lot; a full time
> person.

Maybe it's just me, but wouldn't be this fixed by just asking developers
to document their code? I maintain the LinuxChanges page at kernelnewbies
and very often I see things merged with zero documentation that I can't
understand even trying to understand the code and I need some googling.
For example, in 2.6.19 there're several "UTS namespace" patches that I
just don't really know exactly what they do...

One of the biggest problems I see when looking at Documentation/ (I
tried to update and fix the sysctl documentation; someone probably feed
me some drugs) is that out-of-code documentation that tries to explain
what the code does, like sysctls, just gets outdated (and that's if the
feature is lucky enought to get documented :) 

The "in-code" documentation using kernel-doc seems to incite developers
to document their code and update it. I think that it should be possible
to document things like sysctls or sysfs. Sysfs really needs something
like that, there's a lot of things in sysfs that aren't documented at all
and the few ones that are documented in Documentation/ are documented
in separated files that _will_ get outdated just like sysctls did. Not
that a "documentation guy" is a bad idea, but I think that getting the
developers envolved in the documentation process would be a better first
step :)
