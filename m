Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262532AbUJ0Vtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262532AbUJ0Vtz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 17:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbUJ0VtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 17:49:12 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:19918 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id S262532AbUJ0VnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 17:43:16 -0400
Date: Wed, 27 Oct 2004 14:43:04 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dual Opteron box, what's the optimal memory placement for the
 CPUs?
In-Reply-To: <Pine.LNX.4.61.0410272316160.3284@dragon.hygekrogen.localhost>
Message-ID: <Pine.LNX.4.61.0410271439000.6240@twin.uoregon.edu>
References: <Pine.LNX.4.61.0410272316160.3284@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004, Jesper Juhl wrote:

>
> Quick question,
>
> I've got an IBM eServer 325 here with 2 Opteron 240 CPUs. The box has 6
> DIMM slots, 4 for the "primary" CPU and 2 for the second one. I've got the
> following memory sticks : 4x512MB and 2x1GB
>
> My plan is to plug the 4 512MB sticks into the slots for the first CPU and
> the 2GB sticks into the two slots for the second CPU, giving them 2GB
> each, but I could also give the first one 2x512MB and 2x1GB and the second
> one 2x512MB giving the first CPU 3GB and the second 1GB. Does it matter at
> all.

doesn't really matter, they just have to be installed in pairs for bank 
interleaving. node interleaving is dependant on having banks on both cpu's 
populated.

> and if it does, what's the optimal configuration?
>
> --
> Jesper Juhl
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli  	       Unix Consulting 	       joelja@darkwing.uoregon.edu 
GPG Key Fingerprint:     5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2

