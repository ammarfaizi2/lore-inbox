Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263958AbSJJUTr>; Thu, 10 Oct 2002 16:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263837AbSJJUOR>; Thu, 10 Oct 2002 16:14:17 -0400
Received: from holomorphy.com ([66.224.33.161]:61419 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262610AbSJJUG7>;
	Thu, 10 Oct 2002 16:06:59 -0400
Date: Thu, 10 Oct 2002 13:09:25 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Sampsa Ranta <sampsa@netsonic.fi>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops with?2.5.40
Message-ID: <20021010200925.GW10722@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hugh Dickins <hugh@veritas.com>, Sampsa Ranta <sampsa@netsonic.fi>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20021010194950.GU10722@holomorphy.com> <Pine.LNX.4.44.0210102102190.9566-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210102102190.9566-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2002, William Lee Irwin III wrote:
>> Fixed by Hugh in:
>> ChangeSet@1.750, 2002-10-10 11:03:56-07:00, akpm@digeo.com
>>   [PATCH] mremap use-after-free bugfix

On Thu, Oct 10, 2002 at 09:05:07PM +0100, Hugh Dickins wrote:
> Actually no: similar, but this one was fixed by Hugh in 2.5.41:
> --- 2.5.40/mm/mprotect.c	Fri Sep 27 23:56:45 2002
> +++ 2.5.41/mm/mprotect.c	Mon Oct  7 20:37:50 2002
> @@ -186,8 +186,10 @@

Heh, with the amount of stuff you're fixing it's hard to keep track. =)


Bill
