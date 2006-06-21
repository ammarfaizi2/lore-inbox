Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWFUOkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWFUOkv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWFUOkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:40:51 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:37093 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S932087AbWFUOkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:40:49 -0400
Date: Wed, 21 Jun 2006 23:41:54 +0900 (JST)
Message-Id: <20060621.234154.25912435.anemo@mba.ocn.ne.jp>
To: nish.aravamudan@gmail.com
Cc: linux-kernel@vger.kernel.org, rpurdie@rpsys.net, akpm@osdl.org
Subject: Re: [PATCH] LED: add LED heartbeat trigger
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <29495f1d0606200954u3e81acb4w648d5c31e8daff3a@mail.gmail.com>
References: <20060621.013603.132759710.anemo@mba.ocn.ne.jp>
	<29495f1d0606200954u3e81acb4w648d5c31e8daff3a@mail.gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006 09:54:59 -0700, "Nish Aravamudan" <nish.aravamudan@gmail.com> wrote:
> Can these and the other HZ/100 users make use of the existing
> *secs_to_jiffies() methods? FYI, if HZ=250, you're getting rounding
> here, not sure if it's desired.

Thanks.  The msecs_to_jiffies makes code more readable.  The rounding
is not serious here.

> setup_timer()? (which will call init_timer() before returning.

Sure.  I'll post a new patch soon.

---
Atsushi Nemoto
