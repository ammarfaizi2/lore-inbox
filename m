Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316695AbSIEDza>; Wed, 4 Sep 2002 23:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316728AbSIEDza>; Wed, 4 Sep 2002 23:55:30 -0400
Received: from [64.6.248.2] ([64.6.248.2]:22435 "EHLO greenie.frogspace.net")
	by vger.kernel.org with ESMTP id <S316695AbSIEDz3>;
	Wed, 4 Sep 2002 23:55:29 -0400
Date: Wed, 4 Sep 2002 20:59:55 -0700 (PDT)
From: Peter <cogweb@cogweb.net>
X-X-Sender: cogweb@greenie.frogspace.net
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-ac4 build problem
In-Reply-To: <Pine.LNX.4.44.0209032237460.25475-100000@greenie.frogspace.net>
Message-ID: <Pine.LNX.4.44.0209042038490.13193-100000@greenie.frogspace.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hm, I think you will have to compile the input stuff into the core, if
> you want your USB input drivers to link properly.  So there's really no
> way around this.

In that case, why don't we remove the choice to make modules in input core
support? 

If there's some reason to keep it, let's save someone some grief and add a
note to CONFIG_INPUT:

Note that in most cases, input support must be compiled into the core for
your USB input drivers to link properly.

Alternatively, add this text to the help screens for the three device
types.

Cheers,
Peter

