Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265816AbTABGRs>; Thu, 2 Jan 2003 01:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265854AbTABGRs>; Thu, 2 Jan 2003 01:17:48 -0500
Received: from smtp-outbound.cwctv.net ([213.104.18.10]:2117 "EHLO
	smtp.cwctv.net") by vger.kernel.org with ESMTP id <S265816AbTABGRq>;
	Thu, 2 Jan 2003 01:17:46 -0500
From: <Hell.Surfers@cwctv.net>
To: paul@clubi.ie, riel@conectiva.com.br, linux-kernel@vger.kernel.org,
       rms@gnu.org
Date: Thu, 2 Jan 2003 06:25:30 +0000
Subject: RE:Re: Why is Nvidia given GPL'd code to use in closed source drivers?
MIME-Version: 1.0
X-Mailer: Liberate TVMail 2.6
Content-Type: multipart/mixed;
 boundary="1041488730704"
Message-ID: <0217c2625060213DTVMAIL2@smtp.cwctv.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1041488730704
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

linus cant alter the GPL, which is gooooood :-), he cant change the license at all... Imagine the people that would sue :-).

Dean McEwan, If the drugs don't work, [sarcasm] take more...[/sarcasm].

On 	Thu, 2 Jan 2003 00:31:13 +0000 (GMT) 	Paul Jakma <paul@clubi.ie> wrote:

--1041488730704
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: from vger.kernel.org ([209.116.70.75]) by smtp.cwctv.net  with Microsoft SMTPSVC(5.5.1877.447.44);
	 Thu, 2 Jan 2003 00:30:36 +0000
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265242AbTABAWw>; Wed, 1 Jan 2003 19:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265243AbTABAWw>; Wed, 1 Jan 2003 19:22:52 -0500
Received: from hibernia.jakma.org ([212.17.32.129]:6276 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP
	id <S265242AbTABAWv>; Wed, 1 Jan 2003 19:22:51 -0500
Received: from fogarty.jakma.org (IDENT:PdCp5QtFgA2grkBheD0MZp0P/N0LGalA@fogarty.jakma.org [192.168.0.4])
	by hibernia.jakma.org (8.11.6/8.11.6) with ESMTP id h020VBO15991;
	Thu, 2 Jan 2003 00:31:11 GMT
Received: from localhost (paul@localhost)
	by fogarty.jakma.org (8.11.6/8.11.6) with ESMTP id h020VDJ12820;
	Thu, 2 Jan 2003 00:31:13 GMT
X-Authentication-Warning: fogarty.jakma.org: paul owned process doing -bs
Date: Thu, 2 Jan 2003 00:31:13 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Rik van Riel <riel@conectiva.com.br>
cc: Hell.Surfers@cwctv.net, <linux-kernel@vger.kernel.org>,
	<rms@gnu.org>
Subject: Re: Why is Nvidia given GPL'd code to use in closed source drivers?
In-Reply-To: <Pine.LNX.4.50L.0301011439540.2429-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44.0301012356270.8691-100000@fogarty.jakma.org>
X-NSA: iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Return-Path: linux-kernel-owner+Hell.Surfers=40cwctv.net@vger.kernel.org

On Wed, 1 Jan 2003, Rik van Riel wrote:

> Copyright law is pretty explicit about the situations the GPL
> applies to.  If something can be reasonably considered to be a
> "derivative work" of a GPL work, the GPL applies and the new work
> needs to be GPL.

and:

> but only a song.  If nvidia's driver only uses some simple
> declarations from include files and no large (>7 lines? >10lines?
> what's large?) inline functions AND the nvidia driver uses only the
> standard interfaces to hook into the Linux kernel, then it's not a
> derivative work and nvidia gets to choose the license.

It has long been held that linking to GPL code is suffient to 
consitute 'derived work' status, hence the existence of the LGPL.

The NVidia shim makes use of several kernel subsystems, the PCI
device layer, the VM, the module system (well really, the kernel
makes of use of the functions the module provides :) ), IRQ
subsystem, the VFS, etc.. These systems are rather large bodies of
code - without which the NVidia kernel driver could not work.

So I am not quite sure on what basis one could argue the NVidia 
driver is not a derivative work, and hence it seems to me the NVidia 
driver is technically in material breach of GPL.

You seem to be basing your opinion on:

 "the nvidia driver uses only the standard interfaces to hook into
 the Linux kernel"

How are the standard interfaces not covered by the GPL? 

I know Linus' has often posted to l-k that he doesnt care about
binary only modules as long as they stick to the exported interfaces.  
However, are all the kernel developers agreed on this? And if so, can
this exception be formalised and put into the COPYING file? If not, 
then is NVidia not in breach of the kernel's licence?

> Rik

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
	warning: do not ever send email to spam@dishone.st
Fortune:
Programmers do it bit by bit.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--1041488730704--


