Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135216AbRDZI55>; Thu, 26 Apr 2001 04:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135222AbRDZI5r>; Thu, 26 Apr 2001 04:57:47 -0400
Received: from www.wen-online.de ([212.223.88.39]:10002 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S135216AbRDZI5k>;
	Thu, 26 Apr 2001 04:57:40 -0400
Date: Thu, 26 Apr 2001 10:57:17 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: __alloc_pages: 4-order allocation failed
In-Reply-To: <20010426001539.A14115@vger.timpanogas.org>
Message-ID: <Pine.LNX.4.33.0104261054440.378-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2001, Jeff V. Merkey wrote:

> I am seeing this as well on 2.4.3 with both _get_free_pages() and
> kmalloc().  In the kmalloc case, the modules hang waiting
> for memory.

Would adding __builtin_return_address(0) to the warning help locate?

	-Mike

