Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314106AbSDQVGK>; Wed, 17 Apr 2002 17:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314108AbSDQVGJ>; Wed, 17 Apr 2002 17:06:09 -0400
Received: from vger.timpanogas.org ([216.250.140.154]:38286 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S314106AbSDQVGI>; Wed, 17 Apr 2002 17:06:08 -0400
Date: Wed, 17 Apr 2002 14:26:17 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: James Bourne <jbourne@MtRoyal.AB.CA>, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: Hyperthreading
Message-ID: <20020417142617.B27778@vger.timpanogas.org>
In-Reply-To: <Pine.LNX.4.44.0204171358380.21779-100000@skuld.mtroyal.ab.ca> <1833210000.1019077852@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2002 at 02:10:52PM -0700, Martin J. Bligh wrote:
> > That has balanced the timer irqs.  I've also enabled hyper threading
> > (append="acpismp=force").
> > ...
> > And, you've gotta like this line:
> > Total of 4 processors activated (14299.95 BogoMIPS).
> 
> Before you get too excited about that, how much performance boost do 
> you actually get by turning on Hyperthreading? ;-)
> 

In my testing with SCI, it speeds up some operations and with 3Ware 
it increases throuput about 10 MB/S.  Not a lot but there is some 
improvement (if you can get around the lockups during boot).

Jeff


> M.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
