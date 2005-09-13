Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964957AbVIMSU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbVIMSU1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 14:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbVIMSU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 14:20:27 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:42427 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S964957AbVIMSU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 14:20:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=39fc072/I3isNk72xjmmt3j5J04Eg7qobL3kuY9Kf8vzDgSO+5TJxN+BX9YAkaSxc0xpvvaOCcEQ7KOKFuRCSDS1qz8ITfYhffaTBVQFOXL0YKURBBIUDcsUxxxXrW8/c9XQe54koWojDrMK/GYBBBtfDtSGRqH5i6Yc/ISGNqk=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Andi Kleen <ak@suse.de>
Subject: Re: [patch 3/7] x86_64 linker script cleanups for debug sections
Date: Tue, 13 Sep 2005 19:56:50 +0200
User-Agent: KMail/1.8.1
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <20050910174452.907256000@zion.home.lan> <20050910174628.104571000@zion.home.lan> <p738xy24ytx.fsf@verdi.suse.de>
In-Reply-To: <p738xy24ytx.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509131956.50710.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 September 2005 07:52, Andi Kleen wrote:
> Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it> writes:
> > Use the new macros for x86_64 too.
> >
> > Note that the current scripts includes different definitions; more
> > exactly, it only contains part of the DWARF2 sections and the .comment
> > one from Stabs. Shouldn't be a problem, anyway.
>
> Can you please always cc me on any arch/x86_64,asm-x86_64 patches?
Sorry, forgot this one - 

> > +  STABS_DEBUG
>
> There are no stabs sections on x86-64
Ok, just leave .comment then (if it's actually present and useful) and 
DWARF_DEBUG. Need patch?
> > -  .comment 0 : { *(.comment) }
> > +  DWARF_DEBUG
>
> -Andi

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com
