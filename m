Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129402AbRBID0e>; Thu, 8 Feb 2001 22:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129696AbRBID0Z>; Thu, 8 Feb 2001 22:26:25 -0500
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:23551 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S129402AbRBID0K>; Thu, 8 Feb 2001 22:26:10 -0500
Date: Fri, 9 Feb 2001 04:25:57 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: John Levon <moz@compsoc.man.ac.uk>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Small kernel-hacking.tmpl update
Message-ID: <20010209042557.W16383@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.4.21.0102081348160.16687-100000@mrworry.compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0102081348160.16687-100000@mrworry.compsoc.man.ac.uk>; from moz@compsoc.man.ac.uk on Thu, Feb 08, 2001 at 01:50:00PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2001 at 01:50:00PM +0000, John Levon wrote:
> +   <para>
> +   For more complicated module unload locking requirements, you can set the
> +   <structfield>can_unload</structfield> function pointer to your own routine,
> +   which should return <returnvalue>0</returnvalue> if the module is
> +   unloadable, or <returnvalue>-EBUSY</returnvalue> otherwise.
s/is unloadable/cannot be removed/

This makes it more explicit. You could read "is unloadable" as
"is not loadable", if you are not that familiar with English.

Rest ist correct AFAICS.

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
