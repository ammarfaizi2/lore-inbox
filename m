Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317861AbSHaSek>; Sat, 31 Aug 2002 14:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317862AbSHaSek>; Sat, 31 Aug 2002 14:34:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58637 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317861AbSHaSek>;
	Sat, 31 Aug 2002 14:34:40 -0400
Message-ID: <3D711012.7BFA8119@zip.com.au>
Date: Sat, 31 Aug 2002 11:50:58 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.32-mm4
References: <3D710A93.729F3026@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> ...
> rmap-speedup.patch
>   rmap pte_chain space and CPU reductions
> 

hm.  This accidentally turns on DEBUG_RMAP.  Anyone who is doing
performance testing should turn it off again, in mm/rmap.c
