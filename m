Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262009AbSJIUtW>; Wed, 9 Oct 2002 16:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262021AbSJIUtV>; Wed, 9 Oct 2002 16:49:21 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:53498 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262009AbSJIUtV>; Wed, 9 Oct 2002 16:49:21 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20021009195918.GR26771@phunnypharm.org> 
References: <20021009195918.GR26771@phunnypharm.org>  <20021009144414.GZ26771@phunnypharm.org> <20021009.045845.87764065.davem@redhat.com> <18079.1034115320@passion.cambridge.redhat.com> <20021008.175153.20269215.davem@redhat.com> <200210091149.g99BnWQ5000628@pool-141-150-241-241.delv.east.verizon.net> <7908.1034165878@passion.cambridge.redhat.com> <3DA4392B.8070204@pobox.com> <27367.1034175300@passion.cambridge.redhat.com> <3DA4882A.8000909@pobox.com> 
To: Ben Collins <bcollins@debian.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: BK kernel commits list 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 09 Oct 2002 21:52:52 +0100
Message-ID: <19506.1034196772@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


bcollins@debian.org said:
>  Without the info concerning the file revs being affected, it's pretty
> useless for me. I can actually just use that info and pull diffs
> locally from my repo via sccs.

We can do that. Worst case, someone needs to teach me enough sed to grok 
the 'bk export -tpatch' output, find the line matching
'^# This patch contains the following deltas:$' and spew output from that 
till the first line matching '^#$'. Ideally, there'll be an easier 
way of getting the info from bitkeeper though.

Oh, and would anyone mind if, after feeding the mail through diffstat and 
seeing zero lines of change, I aborted sending the mail?

Further criticism of the scripts will only be accepted in diff -u form 
unless you have an excuse at least as good as having been told personally 
by Larry that you're not allowed to use BitKeeper.

CVSROOT=:pserver:anoncvs@cvs.infradead.org:/home/cvs
grep -q $CVSROOT ~/.cvspass || ( echo "$CVSROOT Ay=0=h<Z" >> ~/.cvspass )
cvs -d $CVSROOT co bkexport

--
dwmw2


