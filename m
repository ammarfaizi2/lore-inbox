Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265033AbSJWO6W>; Wed, 23 Oct 2002 10:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265034AbSJWO6V>; Wed, 23 Oct 2002 10:58:21 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:42744 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265033AbSJWO6V>; Wed, 23 Oct 2002 10:58:21 -0400
Message-ID: <3DB6B96F.A0DE47BF@us.ibm.com>
Date: Wed, 23 Oct 2002 07:59:59 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
X-Mailer: Mozilla 4.72 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: bert hubert <ahu@ds9a.nl>
CC: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, netdev@oss.sgi.com,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND] tuning linux for high network performance?
References: <200210231218.18733.roy@karlsbakk.net> <200210231306.18422.roy@karlsbakk.net> <20021023130101.GA646@outpost.ds9a.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert wrote:

> > ...adding the whole profile output - sorted by the first column this time...
> >
> > 905182 total                                      0.4741
> > 121426 csum_partial_copy_generic                474.3203
> >  93633 default_idle                             1800.6346
> >  74665 do_wp_page                               111.1086
> 
> Perhaps the 'copy' also entails grabbing the page from disk, leading to
> inflated csum_partial_copy_generic stats?

I think this is strictly a copy from user space->kernel and vice versa.
This shouldnt include the disk access etc. 

thanks,
Nivedita
