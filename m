Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbVGKJjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbVGKJjP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 05:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbVGKJjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 05:39:14 -0400
Received: from mailfe10.tele2.fr ([212.247.155.44]:57485 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261476AbVGKJjN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 05:39:13 -0400
X-T2-Posting-ID: k1c2aGMK8Lj9Cnpb+Eju4eOhqUzXuhsckJNC9B9P7R8=
Date: Mon, 11 Jul 2005 11:41:52 +0200
From: Frederik Deweerdt <frederik.deweerdt@gmail.com>
To: Miles Bader <miles@gnu.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] v850: Update checksum.h to match changed function signatures
Message-ID: <20050711094151.GA31805@gilgamesh.home.res>
Mail-Followup-To: Miles Bader <miles@gnu.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <20050711092450.52815625@mctpc71>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20050711092450.52815625@mctpc71>
User-Agent: Mutt/1.5.6i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 11/07/05 18:24 +0900, Miles Bader écrivit:
> 
> -unsigned int csum_partial_copy_from_user (const unsigned char *src, unsigned char *dst,
> +unsigned int csum_partial_copy_from_user (const unsigned char *src,
> +					  unsigned char *dst,
					  ^^^^^^^ Alignment looks fuzzy here
>                                            int len, unsigned int sum,
>                                            int *err_ptr)

Regards,
Frederik Deweerdt
