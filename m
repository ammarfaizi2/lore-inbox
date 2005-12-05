Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbVLEOZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbVLEOZF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 09:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbVLEOZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 09:25:05 -0500
Received: from web30605.mail.mud.yahoo.com ([68.142.200.128]:13911 "HELO
	web30605.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751245AbVLEOZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 09:25:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=tpEONwwYhJ+HkvKmHfJKNKaHIi+7GW5N60UFLX6xI1RDXQkTe3zo6L00gcG6sT2lKGaor6iPaILbxej1lkgNC1+SduCEjhLbwpNVgJsRqn6DmlJrBoygGEeGVsDb9FGx8S4xhZJsDWQijm6LHRkHg9XHqedpKcuneCOuqdD2uP8=  ;
Message-ID: <20051205142502.71657.qmail@web30605.mail.mud.yahoo.com>
Date: Mon, 5 Dec 2005 15:25:02 +0100 (CET)
From: zine el abidine Hamid <zine46@yahoo.fr>
Subject: Re: Kernel BUG at page_alloc.c:117!
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1133791443.9356.23.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I have to use the 2.4.18 kernel because We use an
application which is build on this kernel.
The module are the next one (lsmod):

Module                  Size  Used by    Not tainted
wdpiano                 1920   0  (unused)
w83781d                18592   0  (unused)
via686a                 9924   0 
lm80                    6624   0  (unused)
i2c-proc                8160   0  [w83781d via686a
lm80]
i2c-isa                 1892   0  (unused)
i2c-core               18720   0  [w83781d via686a
lm80 i2c-proc i2c-isa]
autofs                 12164   0  (autoclean) (unused)
parport_pc             18756   1  (autoclean)
plip                   12744   1  (autoclean)
parport                34208   1  (autoclean)
[parport_pc plip]
eepro100               20336   1 
ext3                   67136   2 
jbd                    49400   2  [ext3]



The kernel is (uname) :
Linux Republique_ncl_a 2.4.18-3 #1 Thu Apr 18 07:37:53
EDT 2002 i686 unknown


Zine.

--- Arjan van de Ven <arjan@infradead.org> a écrit :

> On Mon, 2005-12-05 at 14:57 +0100, zine el abidine
> Hamid wrote:
> > Hello Dirk,
> >  
> >  First, thank you for responding so fast.
> >  I have to use the kernel 2.4.18 (or at best the
> > 2.4.22). 
> 
> why?
> 
> >  I want first understand what's appened; 
> 
> something in the kernel did something wrong, which
> caused the VM to
> notice the corruption
> 
> > Is-it a
> > kernel
> >  problem or is-it a bug off our application which
> is
> > written in C++.
> 
> it's probably a driver bug (at least that's most
> common)
> >  It seems like there a bug with the VM; is it
> true?
> 
> no it's something that went wrong and first got
> noticed in the VM,
> that's different from being a bug in the VM.
> 
> 
> which exactly modules were in use? Are there any
> modules that didn't
> come with that kernel? 
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



	

	
		
___________________________________________________________________________ 
Appel audio GRATUIT partout dans le monde avec le nouveau Yahoo! Messenger 
Téléchargez cette version sur http://fr.messenger.yahoo.com
