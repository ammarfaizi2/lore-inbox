Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268986AbTCDB4t>; Mon, 3 Mar 2003 20:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268989AbTCDB4t>; Mon, 3 Mar 2003 20:56:49 -0500
Received: from almesberger.net ([63.105.73.239]:49668 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S268986AbTCDB4s>; Mon, 3 Mar 2003 20:56:48 -0500
Date: Mon, 3 Mar 2003 23:07:06 -0300
From: Werner Almesberger <wa@almesberger.net>
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] make atm (and clip) modular + try_module_get()
Message-ID: <20030303230706.R2791@almesberger.net>
References: <200303032220.h23MKVGi028878@locutus.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303032220.h23MKVGi028878@locutus.cmf.nrl.navy.mil>; from chas@locutus.cmf.nrl.navy.mil on Mon, Mar 03, 2003 at 05:20:31PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chas williams wrote:
> (and exported) and skb_migrate moved to clip -- this really depends

Actually, skb_migrate is something that I'd always have liked to
see getting moved to net/core/skbuff.c, because it seems to provide
a reasonably generic function.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
