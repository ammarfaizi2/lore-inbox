Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261754AbSJIOw6>; Wed, 9 Oct 2002 10:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261793AbSJIOw6>; Wed, 9 Oct 2002 10:52:58 -0400
Received: from blowme.phunnypharm.org ([65.207.35.140]:13060 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S261754AbSJIOw5>; Wed, 9 Oct 2002 10:52:57 -0400
Date: Wed, 9 Oct 2002 10:58:32 -0400
From: Ben Collins <bcollins@debian.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: BK kernel commits list
Message-ID: <20021009145832.GC26771@phunnypharm.org>
References: <20021009144414.GZ26771@phunnypharm.org> <20021009.045845.87764065.davem@redhat.com> <18079.1034115320@passion.cambridge.redhat.com> <20021008.175153.20269215.davem@redhat.com> <200210091149.g99BnWQ5000628@pool-141-150-241-241.delv.east.verizon.net> <7908.1034165878@passion.cambridge.redhat.com> <3DA4392B.8070204@pobox.com> <27367.1034175300@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27367.1034175300@passion.cambridge.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2002 at 03:55:00PM +0100, David Woodhouse wrote:
> 
> bcollins@debian.org said:
> >  Just please make sure that the changeset info where it describes all
> > the files in the delta. I.e. the ones that are moved, deleted, new.
> > There's no way to deduce moves from the patch. 
> 
> This bit?
> 
> # This patch includes the following deltas:
> #                  ChangeSet    1.713   -> 1.714
> #       arch/i386/math-emu/poly.h       1.3     -> 1.4
> #

Yeah, that's it.

> Any idea how to get it other than 'bk export -tpatch | sed' ?

Probably some sort of "bk changes" output. Try checking the -d spec
options.

> I need to do some real work... play with ths script and sort it out between 
> yourselves :)

I can't. Requires using BK :)

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
