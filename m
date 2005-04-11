Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbVDKU3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbVDKU3y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 16:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbVDKU2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 16:28:06 -0400
Received: from mailfe04.swip.net ([212.247.154.97]:13199 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261910AbVDKU0h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 16:26:37 -0400
X-T2-Posting-ID: dB8bZLHXm6KAmbp1mi7F+A==
Subject: Re: [PATCH 1/3] cifs: md5 cleanup - functions
From: Alexander Nyberg <alexn@dsv.su.se>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Steven French <sfrench@us.ibm.com>, Steve French <smfrench@austin.rr.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0504112209220.2480@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0504112209220.2480@dragon.hyggekrogen.localhost>
Content-Type: text/plain
Date: Mon, 11 Apr 2005 22:26:14 +0200
Message-Id: <1113251174.904.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Function names and return types on same line - conform to established 
> fs/cifs/ style.
> 
> -void
> -MD5Init(struct MD5Context *ctx)
> +void MD5Init(struct MD5Context *ctx)
>  {
>  	ctx->buf[0] = 0x67452301;
>  	ctx->buf[1] = 0xefcdab89;
> @@ -60,8 +58,7 @@ MD5Init(struct MD5Context *ctx)
>   * Update context to reflect the concatenation of another buffer full
>   * of bytes.
>   */
> -void
> -MD5Update(struct MD5Context *ctx, unsigned char const *buf, unsigned len)
> +void MD5Update(struct MD5Context *ctx, unsigned char const *buf, unsigned len)
>  {

Can anyone enlighten me why CIFS is not using crypto/md5?
Same question about md4

