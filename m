Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316973AbSFKJaT>; Tue, 11 Jun 2002 05:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316978AbSFKJaR>; Tue, 11 Jun 2002 05:30:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38925 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316973AbSFKJaP>;
	Tue, 11 Jun 2002 05:30:15 -0400
Message-ID: <3D05C401.C9DFC996@zip.com.au>
Date: Tue, 11 Jun 2002 02:33:53 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 no timestamp update on modified mmapped files
In-Reply-To: <3D05A6A1.328B7FDE@zip.com.au> <Pine.LNX.4.21.0206111006300.1028-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> 
> On Tue, 11 Jun 2002, Andrew Morton wrote:
> >
> > I think it's too late to fix this in 2.4.  If we did, a person
> > could develop and test an application on 2.4.21, ship it, then
> > find that it fails on millions of 2.4.17 machines.
> 
> Oh, please reconsider that!  Doesn't loss of modification time
> approach data loss?  Surely we'll continue to fix any data loss
> issues in 2.4, and be grateful if you fixed this mmap modtime loss.
> 

Oh that's easy - I'll complete the patch and let Marcelo worry
about it.

-
