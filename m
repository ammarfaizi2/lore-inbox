Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129153AbQKXEGo>; Thu, 23 Nov 2000 23:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129219AbQKXEGe>; Thu, 23 Nov 2000 23:06:34 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:40458 "EHLO
        wire.cadcamlab.org") by vger.kernel.org with ESMTP
        id <S129153AbQKXEG1>; Thu, 23 Nov 2000 23:06:27 -0500
Date: Thu, 23 Nov 2000 21:36:22 -0600
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Bernd Eckenfels <ecki@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: beware of dead string constants
Message-ID: <20001123213622.A8881@wire.cadcamlab.org>
In-Reply-To: <E13z5nt-0007ig-00@calista.inka.de> <3A1DAAAD.28786302@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A1DAAAD.28786302@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Nov 23, 2000 at 06:39:25PM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Jeff Garzik]
> If you mean preferring 'if ()' over 'ifdef'... Linus.  :) And I agree
> with him: code looks -much- more clean without ifdefs.  And the
> compiler should be smart enough to completely eliminate code inside
> an 'if (0)' code block.

Plus the advantage/disadvantage of making the compiler parse almost
everything, which should eliminate syntax errors, variable name
misspellings, etc in little-used config options.  The disadvantage is
that compilation speed goes down.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
