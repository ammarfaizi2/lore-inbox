Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030298AbWF0TWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbWF0TWc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 15:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbWF0TWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 15:22:32 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:14598 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030298AbWF0TWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 15:22:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RUg1R1GEr/y2QxwFkghvJ9eyWSoG+xSM7eikQAnrI88w/zKlSUrNNKypOdm5Cyst+k0rUNSSvH8pmGhGRzLBRAFQFCHMuzy/sN9L52RHaR03hT8R4YCvus6BRKbUnYsWGHZej5d6GK1vtsrAmq89Do4UOIG7YZVOHLXhbWl54nc=
Message-ID: <cda58cb80606271222x39eb9540y9a3246df8405b01c@mail.gmail.com>
Date: Tue, 27 Jun 2006 21:22:29 +0200
From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
To: "Dave Hansen" <haveblue@us.ibm.com>
Subject: Re: [PATCH 7/7] bootmem: miscellaneous coding style fixes
Cc: "Andrew Morton" <akpm@osdl.org>, "Mel Gorman" <mel@skynet.ie>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <1151429185.24103.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <449FDD02.2090307@innova-card.com>
	 <1151344691.10877.44.camel@localhost.localdomain>
	 <44A12A91.5030704@innova-card.com>
	 <1151429185.24103.8.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/6/27, Dave Hansen <haveblue@us.ibm.com>:
> On Tue, 2006-06-27 at 14:54 +0200, Franck Bui-Huu wrote:
> >  }
> > +
> >  /*
> >   * link bdata in order
> >   */
> >  static void __init link_bootmem(bootmem_data_t *bdata)
> >  {
> >         bootmem_data_t *ent;
> > +
> >         if (list_empty(&bdata_list)) {
>
> I'd discourage you from including too many of these in your patches.
> One or two is probably OK.  But, there are a bunch of them, and it isn't
> clear CodingStyle to have spacing like this either way.  I'd drop them.
>

IMHO they make the code obviously more readable and obviously do not
add any new bugs. So why drop them ?

-- 
               Franck
