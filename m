Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262130AbSJJTm3>; Thu, 10 Oct 2002 15:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262133AbSJJTm3>; Thu, 10 Oct 2002 15:42:29 -0400
Received: from dsl-213-023-020-143.arcor-ip.net ([213.23.20.143]:37315 "EHLO
	starship") by vger.kernel.org with ESMTP id <S262130AbSJJTm2>;
	Thu, 10 Oct 2002 15:42:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Christoph Hellwig <hch@sgi.com>, marcelo@conectiva.com.br
Subject: Re: [PATCH][5th RESENT] cleanup b_inode usage and fix onstack inode abuse
Date: Thu, 10 Oct 2002 21:47:56 +0200
X-Mailer: KMail [version 1.3.2]
Cc: sct@redhat.com, akpm@zip.com.au, linux-kernel@vger.kernel.org
References: <20021004203242.B9813@sgi.com>
In-Reply-To: <20021004203242.B9813@sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17zjHp-0000Dy-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 October 2002 02:32, Christoph Hellwig wrote:
> +	if (unlikely(buffer_attached(bh)))
>  		BUG();

	BUG_ON(buffer_attached(bh));

-- 
Daniel
