Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274887AbSKEDMo>; Mon, 4 Nov 2002 22:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274890AbSKEDMo>; Mon, 4 Nov 2002 22:12:44 -0500
Received: from almesberger.net ([63.105.73.239]:23561 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S274887AbSKEDMm>; Mon, 4 Nov 2002 22:12:42 -0500
Date: Tue, 5 Nov 2002 00:19:05 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Module loader against 2.5.46: 8/9
Message-ID: <20021105001905.D1407@almesberger.net>
References: <20021105002215.8EEE22C0F8@lists.samba.org> <20021105005213.D57732C069@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021105005213.D57732C069@lists.samba.org>; from rusty@rustcorp.com.au on Tue, Nov 05, 2002 at 11:43:42AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Cc: trimmed ]

Rusty Russell wrote:
> +config OBSOLETE_MODPARM
> +	bool
> +	default y
> +	help
> +	  Without this option you will not be able to use module parameters on
> +	  modules which have not been converted to the new module parameter
> +	  system yet.  If unsure, say Y.

Triple negation, cool :-) How about something like

	You need this option to use module parameters on
	modules which have not been converted to the new module parameter
	system yet.  If unsure, say Y.

instead ?

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
