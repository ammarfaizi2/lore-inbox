Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261867AbREUHvm>; Mon, 21 May 2001 03:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261864AbREUHvd>; Mon, 21 May 2001 03:51:33 -0400
Received: from are.twiddle.net ([64.81.246.98]:28166 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S261867AbREUHvX>;
	Mon, 21 May 2001 03:51:23 -0400
Date: Mon, 21 May 2001 00:51:13 -0700
From: Richard Henderson <rth@twiddle.net>
To: Keith Owens <kaos@ocs.com.au>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Geert Uytterhoeven <geert@linux-m68k.org.com>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: const __init
Message-ID: <20010521005113.A19651@twiddle.net>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Geert Uytterhoeven <geert@linux-m68k.org.com>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <3B083878.1785C27D@mandrakesoft.com> <13469.990414470@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <13469.990414470@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Mon, May 21, 2001 at 01:07:50PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2001 at 01:07:50PM +1000, Keith Owens wrote:
> does cause a section conflict, egcs 1.1.2.
> 
> Interestingly enough, if var[12] are together, without the intervening
> text, then gcc does not flag an error, instead it puts both variables
> in section .data.init and marks it as read only.  This looks like a bug
> in gcc.

Fixed in compilers newer than 2 years old.


r~
