Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbUBXBTM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 20:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbUBXBRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 20:17:01 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:47802 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S262131AbUBXBPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 20:15:01 -0500
From: Darren Williams <dsw@gelato.unsw.edu.au>
To: LKML <linux-kernel@vger.kernel.org>
Date: Tue, 24 Feb 2004 12:14:58 +1100
Cc: Ia64 Linux <linux-ia64@vger.kernel.org>
Subject: Re: [BUG] 2.6.3 Slab corruption: errors are triggered when memory exceeds 2.5GB (correction)
Message-ID: <20040224011458.GA18070@cse.unsw.EDU.AU>
References: <20040224002237.GE8906@cse.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040224002237.GE8906@cse.unsw.EDU.AU>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Darren

On Tue, 24 Feb 2004, Darren Williams wrote:

> 
> On Ia64 Itanium 1 machines with more than 2.5GB of RAM the follwing error is triggered.
>  
> slab error in check_poison_obj(): cache `size-16384': object was modified after freeing
> 
> The machine that triggered the error above is an
> 
> i2000 HP workstation
> 4gb RAM
> 1gb SWAP
> 
> An identical machine with 3GB ram produces:
                            ^^^
 
> slab error in check_poison_obj(): cache `size-2048': object was modified after freeing
> 
> if the amount of RAM is reduced to 2.5GB or less then the errors do not appear.
                                     ^^^^^ 

> Kernel logs and configs can be found at:
> http://quasar.cse.unsw.edu.au/~dsw/public-files/lemon-debug/
> 
> 
> --------------------------------------------------
> Darren Williams <dsw AT gelato.unsw.edu.au>
> Gelato@UNSW <www.gelato.unsw.edu.au>
> --------------------------------------------------
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ia64" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--------------------------------------------------
Darren Williams <dsw AT gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------
