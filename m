Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282508AbRLKSib>; Tue, 11 Dec 2001 13:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282502AbRLKSiW>; Tue, 11 Dec 2001 13:38:22 -0500
Received: from dsl-213-023-043-244.arcor-ip.net ([213.23.43.244]:37132 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S282499AbRLKSiM>;
	Tue, 11 Dec 2001 13:38:12 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: volodya@mindspring.com, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: mm question
Date: Tue, 11 Dec 2001 19:39:57 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.20.0112110603400.21886-100000@node2.localnet.net>
In-Reply-To: <Pine.LNX.4.20.0112110603400.21886-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Drp1-0001Jj-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 11, 2001 12:07 pm, volodya@mindspring.com wrote:
> On 11 Dec 2001, Eric W. Biederman wrote:
> > There is actually a cheap trick that will achieve what you want.
> > Allocate pages.  If you allocate a page in the 0-64mb range keep
> > it allocated until you have allocated your 300KB > 64mb.  After
> > you have all of the pages you want free the extra pages in 0-64mb that
> > you didn't want...
> 
> Yes, I thought of that, but this might produce more memory pressure than
> needed. 
> 
> Regardless, it looks like I won't need this after all - the device has
> internal memory controller which was misprogrammed. I think I corrected
> this so it looks to be working now.
> 
> However, the question of how to get pages from a given range is
> interesting in itself..

Yes, particularly numa folks.

--
Daniel
