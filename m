Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136799AbREISHj>; Wed, 9 May 2001 14:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136801AbREISH3>; Wed, 9 May 2001 14:07:29 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:42804 "EHLO
	c0mailgw09.prontomail.com") by vger.kernel.org with ESMTP
	id <S136799AbREISHX>; Wed, 9 May 2001 14:07:23 -0400
Message-ID: <3AF98697.44437FEB@mvista.com>
Date: Wed, 09 May 2001 11:04:07 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Eli Carter <eli.carter@inet.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: standard queue implementation?
In-Reply-To: <3AF96062.19528A86@inet.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eli Carter wrote:
> 
> All,
> 
> I did a quick look in include/linux for a standard implementation of an
> array-based circular queue, but I didn't see one.
> 
> I was thinking something that could be declared, allocated, and then
> used with an addq and a removeq.  A deallocator would also be good.
> 
> Is there such a beast in the kernel?  If not, it seems that having
> something like this would reduce the potential for bugs.
> 
> Thoughts?
> 
Are you possibly looking for include/linux/list.h ?

Routines to build and manager doubly linked circular lists.

George
