Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314670AbSEXRm7>; Fri, 24 May 2002 13:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314690AbSEXRm6>; Fri, 24 May 2002 13:42:58 -0400
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:19629 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S314670AbSEXRm5>; Fri, 24 May 2002 13:42:57 -0400
Date: Fri, 24 May 2002 19:42:45 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: "David S. Miller" <davem@redhat.com>
cc: alan@lxorguk.ukuu.org.uk, tori@ringstrom.mine.nu, imipak@yahoo.com,
        linux-kernel@vger.kernel.org
Subject: Re: Linux crypto?
In-Reply-To: <20020524.102137.04012600.davem@redhat.com>
Message-ID: <Pine.GSO.4.05.10205241938290.11037-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 May 2002, David S. Miller wrote:

>    From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
>    Date: Fri, 24 May 2002 19:32:48 +0200 (MET DST)
>    
>    what about freeswan - with some cleanups?
> 
> They won't let me (or any other US citizen) make any edits to any of
> the ipsec sources if it were to be added to the main tree.  That's
> unacceptable because it means that effectively I cannot maintain the
> networking.

well the _big_ thing the freeswan people are afraid of, is exactly the
crypto laws in the us.

- here is a proposal which should be acceptable (at least i hope so :)

what about taking out the libdes stuff, and make it available from
elsewhere, and hook it into the kernel as a module?
the main kernel could come with a null crypto implementation - which
makes no sense to use, but it will allow to meintain the whole system
without having to worry about the crypto stuff per se (this shouldn't
change very much in any case)

	any comments?

		tm

-- 
in some way i do, and in some way i don't.

