Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287287AbSAXK5y>; Thu, 24 Jan 2002 05:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287279AbSAXK5f>; Thu, 24 Jan 2002 05:57:35 -0500
Received: from port-213-20-228-147.reverse.qdsl-home.de ([213.20.228.147]:43268
	"EHLO drocklinux.dyndns.org") by vger.kernel.org with ESMTP
	id <S287244AbSAXK5b> convert rfc822-to-8bit; Thu, 24 Jan 2002 05:57:31 -0500
Date: Thu, 24 Jan 2002 11:56:53 +0100 (CET)
Message-Id: <20020124.115653.730556705.rene.rebe@gmx.net>
To: mingo@elte.hu
Cc: zdenek@smetana.com, linux-kernel@vger.kernel.org
Subject: Re: Missing changelog to Ingo's J5 scheduler?
From: Rene Rebe <rene.rebe@gmx.net>
In-Reply-To: <Pine.LNX.4.33.0201241255240.7900-100000@localhost.localdomain>
In-Reply-To: <20020124.105517.730550260.rene.rebe@gmx.net>
	<Pine.LNX.4.33.0201241255240.7900-100000@localhost.localdomain>
X-Mailer: Mew version 2.1 on XEmacs 21.4.6 (Common Lisp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Missing changelog to Ingo's J5 scheduler?
Date: Thu, 24 Jan 2002 12:56:09 +0100 (CET)

> 
> On Thu, 24 Jan 2002, Rene Rebe wrote:
> 
> > Yes. -J5 is even better here. With -J4 moving windows arround or doing
> > other GUI intensive stuff was interactive for a short time (1-2
> > seconds?) - and then the programm lost all interactivity (with some
> > unniced gcc in the background ...). With -J5 all applications keep
> > smoth even with two rebuilds (unniced) of a distribution running!
> 
> could you also compare -J5 to -J2? [use the 2.4 patch, or vanilla
> 2.5.3-pre4 which has J2.]

Ok. After some massive rebooting:

-J2 is worser. starting XFree(+gnome) when three gcc's are running
take long (> half a minute?). With -J5 X start nearly normal (mostly
file access time anyway?) Dragging windows arround is nearly
equal. Although with -J2 i sometimes noticed a really big latency when
starting vim or man ...

Oh. btw. The -J5 was tested with 2.4.18-pre7; the rest was with
vanilla-2.4.17 - I hope this doesn't make a performance difference for
this tests ...

> 	Ingo

k33p h4ck1n6
  René

-- 
René Rebe (Registered Linux user: #248718 <http://counter.li.org>)

eMail:    rene.rebe@gmx.net
          rene@rocklinux.org

Homepage: http://drocklinux.dyndns.org/rene/

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
