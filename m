Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbTEYRLm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 13:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbTEYRLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 13:11:42 -0400
Received: from mail.gmx.de ([213.165.64.20]:47642 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263568AbTEYRLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 13:11:41 -0400
Message-ID: <3ED0FC58.D1F04381@gmx.de>
Date: Sun, 25 May 2003 19:24:40 +0200
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Resend [PATCH] Make KOBJ_NAME_LEN match BUS_ID_SIZE
References: <20030525112150.3994df9b.l.s.r@web.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

René Scharfe wrote:
> +size_t strlcpy(char *dest, const char *src, size_t bufsize)
> +{
> +       size_t len = strlen(src);
> +       size_t ret = len;
> +
> +       if (bufsize == 0)
> +               return 0;

                  return ret; ???
