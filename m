Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267330AbTABXuT>; Thu, 2 Jan 2003 18:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267331AbTABXuT>; Thu, 2 Jan 2003 18:50:19 -0500
Received: from vger.timpanogas.org ([216.250.140.154]:46818 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S267330AbTABXuS>; Thu, 2 Jan 2003 18:50:18 -0500
Date: Thu, 2 Jan 2003 18:08:49 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       jmerkey@timpanogas.org
Subject: Re: Questton about Zone Allocation 2.4.X
Message-ID: <20030102180849.A21498@vger.timpanogas.org>
References: <20030102175517.A21471@vger.timpanogas.org> <20030102235147.GS9704@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030102235147.GS9704@holomorphy.com>; from wli@holomorphy.com on Thu, Jan 02, 2003 at 03:51:47PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> __get_free_pages() allocates from lowmem (i.e. 0-4GB) only.
> Allocate from highmem instead.

0-4GB is where I need to allocate, so allocating from highmem is not 
a solution.  I found the Ingo/Andrea patch for RH 8.0, but this patch 
looks a little scary since it affects the memory allocations between
user and kernel space and the ratios alloted to these areas (I may 
be missing something here -- as Dave M. puts it "Jeff you are such a pain
in the ass sometimes"  :-).  

Jeff


> 
> 
> Bill
