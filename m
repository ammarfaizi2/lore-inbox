Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313687AbSEEV7X>; Sun, 5 May 2002 17:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313698AbSEEV7W>; Sun, 5 May 2002 17:59:22 -0400
Received: from dsl-213-023-038-176.arcor-ip.net ([213.23.38.176]:47291 "EHLO
	starship") by vger.kernel.org with ESMTP id <S313687AbSEEV7W>;
	Sun, 5 May 2002 17:59:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch 7/10] handle concurrent block_write_full_page and set_page_dirty
Date: Sun, 5 May 2002 23:58:43 +0200
X-Mailer: KMail [version 1.3.2]
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3CD59CCE.D9979513@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E174U1j-0004Ay-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 05 May 2002 22:57, Andrew Morton wrote:
> +	 * Buffers outside i_size may be dirtied by __set_page_dirty_buffers;
> +	 * handle that here by just cleaning them.

"Cleaning", to me at least, means writing out as a prelude to setting clean.
I'm think meant 'just setting them clean'.

-- 
Daniel
