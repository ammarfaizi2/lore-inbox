Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267815AbTBJCAa>; Sun, 9 Feb 2003 21:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267823AbTBJCAa>; Sun, 9 Feb 2003 21:00:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22790 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267815AbTBJCA2>;
	Sun, 9 Feb 2003 21:00:28 -0500
Message-ID: <3E4709E0.8000104@pobox.com>
Date: Sun, 09 Feb 2003 21:09:36 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: syscall documentation
References: <UTC200302062005.h16K5qn23586.aeb@smtp.cwi.nl>
In-Reply-To: <UTC200302062005.h16K5qn23586.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> The note with the above title last week was very successful -
> several people sent man pages. The copyright situation for
> the *xattr pages is not entirely clear yet, but there is
> good hope that it will be soon.
> 
> Let me send five new pages to l-k - maybe someone has
> additions, corrections or comments.
> 
> The first one is alloc_hugepages.2. Below.
> Probably more can be said about hugetlbfs.
> 
> Andries
> aeb@cwi.nl
> 
> ---------
> NAME
>        alloc_hugepages,  free_hugepages  -  allocate or free huge
>        pages
> 
> SYNOPSIS
>        void *alloc_hugepages(int key, void *addr, size_t len, int
>        prot, int flag);
> 
>        int free_hugepages (void *addr);


The other man pages look great.  The above system calls, however, do not 
exist anymore.

This also brings to light that Documentation/vm/hugetlbpage.txt and 
arch/i386/Kconfig want updating, as well as non-ia32 arches...

	Jeff



