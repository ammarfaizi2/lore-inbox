Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267737AbTBKMc2>; Tue, 11 Feb 2003 07:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267792AbTBKMc2>; Tue, 11 Feb 2003 07:32:28 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:48396 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S267737AbTBKMc1>; Tue, 11 Feb 2003 07:32:27 -0500
Date: Tue, 11 Feb 2003 12:42:14 +0000
From: John Levon <levon@movementarian.org>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] oprofile update: CPU type as string
Message-ID: <20030211124214.GA63656@compsoc.man.ac.uk>
References: <20030211114243.GB57908@compsoc.man.ac.uk> <200302111234.h1BCYqgS004257@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302111234.h1BCYqgS004257@eeyore.valparaiso.cl>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18iZjq-0008WH-00*k66zhk6tdo2*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2003 at 01:34:52PM +0100, Horst von Brand wrote:

> Better use "ia32/P4" and so on, "i386/P4" makes little sense ;-)

It's modelled after linux/arch/<blah>

> You could (should?) place the CPU ID into the model spec too...

eh ?

> BTW, if nobody (except masochistic kernel source readers) sees this stuff,
> what is the point? An enum uses less space than a char * + the string.

The type is used by the userspace to determine what counters are
available.

john
