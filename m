Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbWF2RGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWF2RGr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 13:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbWF2RGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 13:06:47 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:11752 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751006AbWF2RGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 13:06:46 -0400
Date: Thu, 29 Jun 2006 13:22:03 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Paolo Ornati <ornati@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH-v2] Documentation: remove duplicated words
Message-ID: <20060629132203.A6460@mail.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060629164128.5ba9d264@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ornati <ornati@fastwebnet.it> wrote:
> 
> Remove every (hopefully) duplicated word under Documentation/ and do
> other small cleanups.
> 
> Examples:
> 	"and and" --> "and"
> 	"in in" --> "in"
> 	...

When the duplicatation was due to a typo, removing the duplicate is the
not the correct fix. Additionally, there are cases where the text
actually reads better (or no worse) with the duplication in place.

> -                        matches the field we filled in in the struct
> +                        matches the field we filled in the struct

Should probably be left as is: "matches the field we (filled in) in
the struct"

> -device. Individual PCI device drivers that have been converted the the current
> +device. Individual PCI device drivers that have been converted the current

First "the" is actually a typo for "to".

> -  a directory entry.  The directory entry requested carries name name
> +  a directory entry.  The directory entry requested carries name
>    and Venus will search the directory identified by cfs_lookup_in.VFid.

Suspect first "name" should be "the".

> -       The CPU to SPU communation mailbox. It is write-only can can be written
> +       The CPU to SPU communation mailbox. It is write-only can be written 

First "can" should be "and".

>  This doesn't seem important in the one button case, but is quite important
> -for for example mouse movement, where you don't want the X and Y values
> +for example mouse movement, where you don't want the X and Y values
>  to be interpreted separately, because that'd result in a different movement.

Probably should be rephrased in general. Author probably intended it to
be parsed as "...but is quite important for, for example, mouse
movement...".

> -a trailing = on the name of any parameter states that that parameter will
> +a trailing = on the name of any parameter states that parameter will

Again, "states that (that parameter)" while not great English is
probably exactly what the author intended.

>  Life isn't quite as simple as it may appear above, however: for while the
> -caches are expected to be coherent, there's no guarantee that that coherency
> +caches are expected to be coherent, there's no guarantee that coherency
>  will be ordered.  This means that whilst changes made on one CPU will

And again: "...no guarantee that (that coherency) will be...".

...possibly more; this is as far as I got.

--Adam

