Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280222AbRJaN7Q>; Wed, 31 Oct 2001 08:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280219AbRJaN7G>; Wed, 31 Oct 2001 08:59:06 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:28895 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S280213AbRJaN65>;
	Wed, 31 Oct 2001 08:58:57 -0500
Date: Wed, 31 Oct 2001 08:59:33 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: BALBIR SINGH <balbir.singh@wipro.com>
cc: Manuel Cepedello Boiso <manuel@cauchy.eii.us.es>,
        linux-kernel@vger.kernel.org
Subject: Re: Oops when unmounting a floppy (linux 2.4.13)
In-Reply-To: <3BDFF478.5030604@wipro.com>
Message-ID: <Pine.GSO.4.21.0110310855110.5536-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 31 Oct 2001, BALBIR SINGH wrote:

> Preliminary analysis shows that getblk now no longer holds lru_list_lock.
> I am sure there is a good reason for that, I hope :-)
> 
> get_hash_table just holds hash_table_lock where as invalidate_buffer
> holds lru_list_lock.

So what?

