Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262683AbRE3Jim>; Wed, 30 May 2001 05:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262684AbRE3Jie>; Wed, 30 May 2001 05:38:34 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:41756 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262683AbRE3Ji1>; Wed, 30 May 2001 05:38:27 -0400
Date: Wed, 30 May 2001 05:38:07 -0400
From: Arjan van de Ven <arjanv@redhat.com>
To: ankry@green.mif.pg.gda.pl
Cc: linux-kernel@vger.kernel.org
Subject: Re: Generating valid random .configs
Message-ID: <20010530053807.A3083@devserv.devel.redhat.com>
In-Reply-To: <3B14AEFC.B522A7B4@redhat.com> <200105300929.LAA02627@sunrise.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200105300929.LAA02627@sunrise.pg.gda.pl>; from ankry@pg.gda.pl on Wed, May 30, 2001 at 11:29:42AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2001 at 11:29:42AM +0200, Andrzej Krzysztofowicz wrote:
> 
> Some things cannot be properly fixed in CML1.
>   "$CONFIG_BINFMT_MISC" = "y" -a "$CONFIG_PROC_FS" = "n"
> is a good example.
> 

This one has gone away btw....

But in general, the current TOOLS cannot do forward dependencies, true.
It's not a language problem, the dependencies can be expressed and should be
checked by the tools, they just don't; I had a fix for that in the 2.1.125 times but
nobody cared enough.

Greetings,
   Arjan van de Ven
