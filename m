Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316601AbSIIITR>; Mon, 9 Sep 2002 04:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316610AbSIIITR>; Mon, 9 Sep 2002 04:19:17 -0400
Received: from pizda.ninka.net ([216.101.162.242]:9373 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316601AbSIIITP>;
	Mon, 9 Sep 2002 04:19:15 -0400
Date: Mon, 09 Sep 2002 01:16:21 -0700 (PDT)
Message-Id: <20020909.011621.71920880.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Important per-cpu fix.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020909180619.7934b455.rusty@rustcorp.com.au>
References: <20020904042036.816A62C1B6@lists.samba.org>
	<al43it$mel$1@cesium.transmeta.com>
	<20020909180619.7934b455.rusty@rustcorp.com.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Mon, 9 Sep 2002 18:06:19 +1000

   On 3 Sep 2002 21:52:45 -0700
   "H. Peter Anvin" <hpa@zytor.com> wrote:
   
   > gcc puts all uninitialized variables in .bss, and it apparently can't
   > be overridden.  This seems to be a side effect of the way gcc handles
   > common variables.
   
   Err... no, as I said, it doesn't happen with 2.95.4 or 3.0.4.
   
But note that older GCCs do have the problem and it isn't platform
specific at all.
